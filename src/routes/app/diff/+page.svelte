<script lang="ts">
	import { diff } from 'json-diff-ts';

	let json1 = '';
	let json2 = '';
	let diffResult: any[] = []; // Use the locally defined IChange type

	function calculateDiff() {
		try {
			const obj1 = JSON.parse(json1);
			const obj2 = JSON.parse(json2);
			const result = diff(obj1, obj2);

			if (result) {
				diffResult = result;
			} else {
				diffResult = [{ type: 'INFO', key: '', value: 'No differences found', oldValue: undefined }];
			}
		} catch (error) {
			diffResult = [{ type: 'ERROR', key: '', value: 'Invalid JSON input', oldValue: undefined }];
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
				bind:value={json1}
				placeholder="Paste the first JSON here..."
			></textarea>
		</div>
		<div class="col-md-6">
			<h4>Actual</h4>
			<textarea
				class="form-control"
				bind:value={json2}
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
			<h4>Result</h4>
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
				<tbody>
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
		</div>
	</div>
</div>

<style>
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
</style>
