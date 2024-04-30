<script lang="ts">
	import { jsonInputStored } from '$lib/store';

	export let jsonInput: string = '';
	export let isValid: boolean = true;

	$: if (jsonInput) {
		validateJson(jsonInput);
	}

	function validateJson(jsonString: string) {
		try {
			JSON.parse(jsonString);
			$jsonInputStored = jsonString;
			isValid = true;
		} catch (error) {
			isValid = false;
		}
	}
</script>

<div>
	<textarea
		class="form-control"
		rows="24"
		bind:value={jsonInput}
		placeholder="Paste a JSON string to validate..."
	></textarea>
	{#if !isValid}
		<p class="text-danger">Invalid JSON input</p>
	{/if}
</div>

<style>
	textarea {
		font-size: 0.9rem;
		font-family: 'PT Mono';
	}
</style>
