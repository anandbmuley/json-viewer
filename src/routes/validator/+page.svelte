<script lang="ts">
	import { onMount } from 'svelte';
	import JsonSchemaInput from '../../components/JsonSchemaInput.svelte';
	import UserJsonInput from '../../components/UserJsonInput.svelte';

	import Ajv from 'ajv';
	const ajv = new Ajv();

	let jsonSchema: string = '';
	let jsonInput: string = '';
	let validationResult: boolean | null = null;

	// This function is called when the JSON schema is submitted
	function handleJsonSchemaSubmission(event: CustomEvent<string>) {
		jsonSchema = event.detail;
	}

	// This function is called when the JSON input is submitted
	function handleJsonInputSubmission(event: CustomEvent<string>) {
		jsonInput = event.detail;
		validateJson();
	}

	// This function validates the JSON input against the JSON schema
	function validateJson() {
		try {
			const validate = ajv.compile(JSON.parse(jsonSchema));
			validationResult = validate(JSON.parse(jsonInput));
		} catch (error) {
			console.error('Error parsing JSON:', error);
			validationResult = false;
		}
	}

	onMount(() => {
		ajv.addSchema(JSON.parse(jsonSchema), 'schema');
	});
</script>

<div class="container mt-3">
	<h3>Validator</h3>
	<div class="row">
		<div class="col-5">
			<JsonSchemaInput />
		</div>
		<div class="col-5">
			<UserJsonInput />
		</div>
	</div>
</div>
