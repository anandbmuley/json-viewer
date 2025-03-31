<script lang="ts">
	import JsonSchemaInput from '../../../components/JsonSchemaInput.svelte';
	import UserJsonInput from '../../../components/UserJsonInput.svelte';
	import SaveJsonSchema from '../../../components/generic/SaveJsonSchema.svelte';
	import ExistingSchemas from '../../../components/functional/ExistingSchemas.svelte';
	import Ajv from 'ajv';
	import { jsonInputStored, jsonSchemaStored, selectedSchema } from '$lib/store';
	import { onMount } from 'svelte';

	const ajv = new Ajv();

	let validationResult = false;
	let errors: Ajv.ErrorObject[] | null | undefined;
	const schema = {
		type: 'object',
		properties: {
			foo: { type: 'integer' },
			bar: { type: 'integer' }
		},
		required: ['foo'],
		additionalProperties: false
	};

	const data = {
		foo: 1,
		bar: 'abc'
	};

	let errorMessage: string = '';
	let successMessage: string = '';

	onMount(() => {
		$jsonSchemaStored = ''; // Clear JSON schema on load
		$jsonInputStored = ''; // Clear JSON input on load
		console.log('Schema', JSON.stringify(schema));
		console.log('Data', JSON.stringify(data));
	});

	function clearSchemaInput() {
		$selectedSchema = '';
	}

	function validateJson() {
		try {
			errorMessage = '';
			successMessage = '';
			if (!$jsonSchemaStored) {
				errorMessage = 'Please provide a JSON schema';
			} else if (!$jsonInputStored) {
				errorMessage = 'Please provide a JSON input';
			} else {
				const validate = ajv.compile(JSON.parse($jsonSchemaStored));
				const valid = validate(JSON.parse($jsonInputStored));
				if (valid) {
					successMessage = 'Validation successful!';
					errors = null;
				} else {
					console.log(validate.errors);
					errors = validate.errors;
				}
			}
		} catch (error) {
			console.error('Error parsing JSON:', error);
			validationResult = false;
		}
	}
</script>

<div class="container-fluid vh-100 d-flex flex-column overflow-hidden">
	<div class="row">
		<div class="col-12 col-md-2">
			<h3>Validator</h3>
		</div>
		<div class="col-12 col-md-2">
			<ExistingSchemas />
		</div>
	</div>
	<div class="row flex-grow-1 overflow-hidden">
		<div class="col-12 col-md-4">
			<JsonSchemaInput />
		</div>
		<div class="col-12 col-md-4">
			<UserJsonInput />
		</div>
		<div class="col-12 col-md-4">
			<h5>Validation result</h5>
			{#if successMessage}
				<p class="text-success">{successMessage}</p>
			{/if}
			{#if errors}
				<ul class="overflow-auto">
					{#each errors as item}
						<li>
							<p class="validation-err">{item.message}</p>
							<p class="validation-path text-danger">{item.schemaPath}</p>
						</li>
					{/each}
				</ul>
			{/if}
		</div>
	</div>
	<div class="row" style="height: 8%">
		<div class="col-12 col-md-3">
			<button on:click={clearSchemaInput} class="btn btn-sm btn-outline-dark">
				<i class="bi bi-x-circle"></i><span class="ms-1">Reset</span>
			</button>
		</div>
		<div class="col-12 col-md-4">
			<SaveJsonSchema jsonContent={$jsonSchemaStored} />
		</div>
		<div class="col-12 col-md-3">
			<button class="btn btn-sm btn-purple" on:click={validateJson}>
				<i class="bi bi-check-circle-fill"></i>
				<span class="ms-1">Validate</span>
			</button>
		</div>
	</div>
	<p class="text-danger">
		{errorMessage}
	</p>
</div>

<style>
	.container-fluid {
		padding: 1rem;
	}

	.row {
		margin-bottom: 1rem;
	}

	.flex-grow-1 {
			overflow: hidden;
	}

	.validation-err {
		font-size: 1.2rem;
		margin-bottom: -1%;
	}

	.validation-path {
		font-size: 1rem;
	}

	.btn-purple {
		background-color: #9000ff;
		border-color: #9000ff;
		color: white;
	}

	.text-success {
		color: green;
		font-size: 1.2rem;
	}
</style>
