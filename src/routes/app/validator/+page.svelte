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

	onMount(() => {
		console.log('Schema', JSON.stringify(schema));
		console.log('Data', JSON.stringify(data));
	});

	function clearSchemaInput() {
		$selectedSchema = '';
	}

	function validateJson() {
		try {
			errorMessage = '';
			if (!$jsonSchemaStored) {
				errorMessage = 'Please provide a JSON schema';
			} else if (!$jsonInputStored) {
				errorMessage = 'Please provide a JSON input';
			} else {
				const validate = ajv.compile(JSON.parse($jsonSchemaStored));
				const valid = validate(JSON.parse($jsonInputStored));
				if (!valid) {
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

<div class="container mt-3">
	<h3>Validator</h3>
	<div class="row mb-3">
		<div class="col-2">
			<SaveJsonSchema jsonContent={$jsonSchemaStored} />
		</div>
		<div class="col-2">
			<ExistingSchemas />
		</div>
	</div>
	<div class="row mb-3">
		<div class="col-4">
			<JsonSchemaInput />
		</div>
		<div class="col-4">
			<UserJsonInput />
		</div>
		<div class="col-4">
			<h5>Validation result</h5>
			{#if errors}
				<ul>
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
	<div class="row">
		<div class="col-4">
			<button on:click={clearSchemaInput} class="btn btn-sm btn-danger">
				<i class="bi bi-x-circle"></i><span class="ms-2 me-2">Clear</span>
			</button>
		</div>
		<div class="col-4">
			<button class="btn btn-sm btn-primary" on:click={validateJson}>Validate</button>
		</div>
	</div>
	<p class="text-danger">
		{errorMessage}
	</p>
</div>

<style>
	.validation-err {
		font-size: 1.2rem;
		margin-bottom: -1%;
	}

	.validation-path {
		font-size: 1rem;
	}
</style>
