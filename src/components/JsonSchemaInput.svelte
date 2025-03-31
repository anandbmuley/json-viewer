<!-- components/JsonSchemaInput.svelte -->
<script lang="ts">
	let jsonSchema: string = '';
	let isValid: boolean = true;
	import { jsonSchemaStored, selectedSchema } from '$lib/store';

	$: if (jsonSchema) {
			validateJson(jsonSchema);
	}

	$: if ($selectedSchema != undefined) {
		jsonSchema = $selectedSchema;
	}

	// This function validates if the input string is valid JSON
	function validateJson(jsonString: string) {
		try {
			JSON.parse(jsonString);
			$jsonSchemaStored = jsonString;
			isValid = true;
		} catch (error) {
			isValid = false;
		}
	}
</script>

<div class="json-schema-input-container">
	<textarea
		class="form-control"
		bind:value={jsonSchema}
		placeholder="Paste the JSON schema here..."
	></textarea>
	{#if !isValid}
		<p class="text-danger">Invalid JSON schema</p>
	{/if}
</div>

<style>
	.json-schema-input-container {
		height: 100%;
		display: flex;
		flex-direction: column;
		overflow: hidden;
	}

	textarea {
		flex-grow: 1;
		font-size: 0.9rem;
		font-family: 'PT Mono';
		resize: none;
		overflow: auto;
	}
</style>
