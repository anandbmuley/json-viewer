<script lang="ts">
	import { diff } from 'json-diff-ts';

	let expectedJson = '';
	let actualJson = ''; 
	let diffResult: any[] = [];
	let noDifferences = false;
	let hasError = false;
	let showResultCount = false;

	function calculateDiff() {
		try {
			const obj1 = JSON.parse(expectedJson); 
			const obj2 = JSON.parse(actualJson); 
			const result = diff(obj1, obj2);

			if (result && result.length > 0) {
				diffResult = result;
				noDifferences = false;
				hasError = false;
				showResultCount = true;
			} else {
				noDifferences = true;
				hasError = false;
				diffResult = [];
				showResultCount = false;
			}
		} catch (error) {
			noDifferences = false;
			hasError = true;
			diffResult = [];
			showResultCount = false;
		}
	}
</script>

<div class="container-fluid full-screen">
	<h3>JSON Diff</h3>
	<div class="row">
		<div class="col-md-6">
			<h4>Expected</h4>
			<textarea
				class="form-control"
				bind:value={expectedJson}
				placeholder="Paste the first JSON here..."
			></textarea>
		</div>
		<div class="col-md-6">
			<h4>Actual</h4>
			<textarea
				class="form-control"
				bind:value={actualJson}
				placeholder="Paste the second JSON here..."
			></textarea>
		</div>
	</div>
	<div class="row mt-3">
		<div class="col-12 text-center">
			<button class="btn btn-purple" on:click={calculateDiff}>Compare</button>
		</div>
	</div>
	<div class="row mt-3">
		<div class="col-12">
			{#if hasError}
				<div class="alert alert-danger text-center">Invalid JSON input</div>
			{:else if noDifferences}
				<div class="alert alert-info text-center">No differences found</div>
			{:else}
				<h4>Result</h4>
				{#if showResultCount}
					<small class="text-purple">Number of differences found: {diffResult.length} (Please scroll the table body to see more)</small>
				{/if}
				<table class="table table-bordered">
					<thead>
						<tr>
							<th>Sr.No</th>
							<th>Type</th>
							<th>Field</th>
							<th>Expected</th>
							<th>Actual</th>
						</tr>
					</thead>
					<tbody class="scrollable-tbody">
						{#each diffResult as { type, key, value, oldValue }, index}
							<tr>
								<td>{index + 1}</td>
								<td>{type}</td>
								<td>{key}</td>
								<td>{oldValue !== undefined ? oldValue : '-'}</td>
								<td>{value !== undefined ? value : '-'}</td>
							</tr>
						{/each}
					</tbody>
				</table>
			{/if}
		</div>
	</div>
</div>

<style>
	.text-purple {
		color: #9000ff;
	}

	.full-screen {
		width: 100vw;
		height: 100vh;
		padding: 20px;
		box-sizing: border-box;
		overflow: auto;
	}
	textarea {
		height: calc(50vh - 150px);
		font-family: 'PT Mono';
		font-size: 0.9rem;
		width: 100%;
		resize: none;
	}
	.btn-purple {
		background-color: #9000ff;
		border-color: #9000ff;
		color: white;
	}
	table {
		width: 100%;
		background-color: #fff;
		border-collapse: collapse;
	}
	th, td {
		padding: 10px;
		text-align: left;
		border: 1px solid #ddd;
	}
	th {
		background-color: #f2f2f2;
	}
	.alert {
		padding: 15px;
		background-color: #e7f3fe;
		border: 1px solid #b3d8fd;
		border-radius: 4px;
		color: #31708f;
	}
	.alert-danger {
		padding: 15px;
		background-color: #f8d7da;
		border: 1px solid #f5c6cb;
		border-radius: 4px;
		color: #721c24;
	}
	.scrollable-tbody {
		display: block;
		max-height: 300px; /* Approximately 5 rows assuming 40px per row */
		overflow-y: auto;
	}
	.scrollable-tbody tr {
		display: table;
		width: 100%;
		table-layout: fixed;
	}
	thead, .scrollable-tbody tr {
		display: table;
		width: 100%;
		table-layout: fixed;
	}
</style>
