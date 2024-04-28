<script lang="ts">
	import TreeView from '../../../components/TreeView.svelte';
	import AddJson from '../../../components/generic/AddJson.svelte';
	import { selectedJSON } from '$lib/store';

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
		<div class="col-5">
			<div class="row">
				<div class="col-4">
					<h3>JSON Content</h3>
				</div>
			</div>
			<div class="row mb-2">
				<div class="col-9">
					<AddJson bind:jsonContent={jsonData} />
				</div>
				<div class="col-3">
					<button on:click={clearJsonContent} type="button" class="btn btn-sm btn-outline-dark">
						Clear<i class="bi bi-x-circle ms-1"></i>
					</button>
				</div>
			</div>
			<textarea
				class="form-control"
				bind:value={jsonData}
				name="jsonData"
				id="json-data"
				placeholder="Paste JSON text..."
			></textarea>
		</div>
		<div class="col-5">
			<h3>Tree View</h3>
			<TreeView bind:data={jsonData} />
		</div>
	</div>
</div>

<style>
	textarea {
		height: 550px;
		font-size: 0.9rem;
		font-family: 'PT Mono';
	}

	h3 {
		font-size: 1.5rem;
	}
</style>
