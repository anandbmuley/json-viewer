<script lang="ts">
	import TreeView from '../../components/TreeView.svelte';
	import AddJson from '../../components/generic/AddJson.svelte';
	import { selectedJSON } from '$lib/store';
	import ExistingJsonSearch from '../../components/functional/ExistingJsonSearch.svelte';
	import EvaluateJsonPath from '../../components/functional/EvaluateJsonPath.svelte';
	import { onMount } from 'svelte';

	let jsonData: string = '';
	let message: string = '';

	$: if (jsonData) {
		try {
			const parsed = JSON.parse(jsonData.trim()); // Trim here instead of reactively
			jsonData = JSON.stringify(parsed, null, 2);
		} catch (err) {
			message = 'Invalid JSON';
		}
	}

	$: if ($selectedJSON != undefined && $selectedJSON !== jsonData) {
		// Update jsonData only if it is empty or matches the previous $selectedJSON
		if (!jsonData || jsonData === $selectedJSON) {
			jsonData = $selectedJSON;
		}
	}

	$: if ($selectedJSON === '') {
		jsonData = ''; // Clear jsonData when the selectedJSON store is cleared
	}

	const clearJsonContent = () => {
		jsonData = '';
		message = ''; // Clear any error messages
		selectedJSON.set(''); // Ensure the store is cleared
	};

	onMount(() => {
		jsonData = ''; // Clear jsonData on page load
		selectedJSON.set(''); // Clear the selectedJSON store on page load
	});
</script>

<div class="container mt-3">
	<div class="row" style="height: calc(100vh - 100px);">
		<div class="col-md-4 d-flex flex-column">
			<div class="row mb-2">
				<div class="col-7">
					<h3>Viewer</h3>
				</div>
				<div class="col-5">
					<ExistingJsonSearch />
				</div>
			</div>
			<textarea
				class="form-control flex-grow-1"
				bind:value={jsonData}
				name="jsonData"
				id="json-data"
				placeholder="Paste JSON text..."
			></textarea>
			<div class="row mt-2">
				<div class="col-6 col-md-10">
					<button on:click={clearJsonContent} type="button" class="btn btn-sm btn-secondary">
						<i class="bi bi-x-circle ms-1"></i>
						<span class="ms-1">Reset</span>
					</button>
				</div>
				<div class="col-6 col-md-2">
					<AddJson bind:jsonContent={jsonData} />
				</div>
			</div>
		</div>
		<div class="col-md-4 d-flex flex-column">
			<h3>Tree View</h3>
			<div class="flex-grow-1 overflow-auto">
				<TreeView bind:data={jsonData} />
			</div>
		</div>
		<div class="col-md-4 d-flex flex-column">
			<h3>Evaluate JSON Path</h3>
			<EvaluateJsonPath bind:jsonData={jsonData} />
		</div>
	</div>
</div>

<style>
	textarea {
		font-size: 0.9rem;
		font-family: 'PT Mono';
		resize: none;
	}
	.container {
		max-width: 100%;
	}
</style>
