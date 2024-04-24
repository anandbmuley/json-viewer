<!-- components/JsonSchemaInput.svelte -->
<script lang="ts">
	import { createEventDispatcher } from 'svelte';
	import { onMount } from 'svelte';

	export let jsonSchema: string = '';
	export let isValid: boolean = true;

	const dispatch = createEventDispatcher();

	// This function emits an event to send the JSON schema to the parent component
	function sendJsonSchema() {
		if (isValid) {
			dispatch('jsonSchemaSubmitted', jsonSchema);
		}
	}

	// This function validates if the input string is valid JSON
	function validateJson(jsonString: string): boolean {
		try {
			JSON.parse(jsonString);
			return true;
		} catch (error) {
			return false;
		}
	}

	onMount(() => {
		isValid = validateJson(jsonSchema);
	});
</script>

<div>
	<textarea bind:value={jsonSchema} placeholder="Enter JSON schema"></textarea>
	{#if !isValid}
		<p style="color: red;">Invalid JSON schema</p>
	{/if}
	<button on:click={sendJsonSchema}>Submit Schema</button>
</div>
