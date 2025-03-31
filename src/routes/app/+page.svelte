<script lang="ts">
	import TreeView from '../../components/TreeView.svelte';
	import AddJson from '../../components/generic/AddJson.svelte';
	import { selectedJSON } from '$lib/store';
	import ExistingJsonSearch from '../../components/functional/ExistingJsonSearch.svelte';

	let jsonData: string = '';
	let message: string = '';

	$: if (jsonData) {
		try {
			const parsed = JSON.parse(jsonData);
			jsonData = JSON.stringify(parsed, null, 2);
		} catch (err) {
			message = 'Invalid JSON';
		}
	}

	$: if ($selectedJSON) {
		jsonData = $selectedJSON;
	}

	const clearJsonContent = () => {
		jsonData = '';
	};
</script>

<div class="container mt-3">
	<div class="row" style="height: calc(100vh - 100px);">
		<div class="col-md-6 col-lg-4 d-flex flex-column">
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
					<button on:click={clearJsonContent} type="button" class="btn btn-sm btn-outline-dark">
						<i class="bi bi-x-circle ms-1"></i>
						<span class="ms-1">Reset</span>
					</button>
				</div>
				<div class="col-6 col-md-2">
					<AddJson bind:jsonContent={jsonData} />
				</div>
			</div>
		</div>
		<div class="col-md-6 col-lg-8 d-flex flex-column">
			<h3>Tree View</h3>
			<div class="flex-grow-1 overflow-auto">
				<TreeView bind:data={jsonData} />
			</div>
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
