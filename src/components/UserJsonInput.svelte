<script lang="ts">
	import { createEventDispatcher } from 'svelte';
	import { onMount } from 'svelte';

	export let jsonInput: string = '';
	export let isValid: boolean = true;

	const dispatch = createEventDispatcher();

	// This function emits an event to send the JSON input to the parent component
	function sendJsonInput() {
		if (isValid) {
			dispatch('jsonInputSubmitted', jsonInput);
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
		isValid = validateJson(jsonInput);
	});
</script>

<div>
	<textarea bind:value={jsonInput} placeholder="Enter JSON input"></textarea>
	{#if !isValid}
		<p style="color: red;">Invalid JSON input</p>
	{/if}
	<button on:click={sendJsonInput}>Submit Input</button>
</div>
