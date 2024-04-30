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
	<div class="row">
		<div class="col-4">
			<div class="row">
				<div class="col-7">
					<h3>Viewer</h3>
				</div>
				<div class="col-5">
					<ExistingJsonSearch />
				</div>
			</div>
			<div class="row mb-2"></div>
			<textarea
				class="form-control"
				bind:value={jsonData}
				name="jsonData"
				id="json-data"
				placeholder="Paste JSON text..."
				rows="24"
			></textarea>
		</div>
		<div class="col-5">
			<h3>Tree View</h3>
			<TreeView bind:data={jsonData} />
		</div>
	</div>
	<div class="row mt-2">
		<div class="col-3">
			<button on:click={clearJsonContent} type="button" class="btn btn-sm btn-outline-dark">
				<i class="bi bi-x-circle ms-1"></i>
				<span class="ms-1">Reset</span>
			</button>
		</div>
		<div class="col-2">
			<AddJson bind:jsonContent={jsonData} />
		</div>
	</div>
</div>

<style>
	textarea {
		font-size: 0.9rem;
		font-family: 'PT Mono';
	}
</style>
