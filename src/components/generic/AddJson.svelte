<script lang="ts">
	import type { Alert } from '$lib/ViewModel';
	import { db } from '$lib/db';

	export let jsonContent = '';
	let title = '';
	let alert: Alert = {
		mesage: '',
		status: 'success'
	};

	const clearMessage = () => {
		alert = {
			mesage: '',
			status: 'success'
		};
	};

	const handleOnSave = async () => {
		try {
			if (jsonContent === undefined || jsonContent === '') {
				alert = {
					mesage: 'No content to save. Please add some content to JSON input',
					status: 'error'
				};
			} else {
				const id = await db.jsons.add({
					title,
					content: jsonContent
				});
				alert = {
					mesage: 'JSON saved successfully',
					status: 'success'
				};
			}
		} catch (err) {
			alert = {
				mesage: `Could not save the JSON: ${err}`,
				status: 'error'
			};
		}
	};
</script>

<!-- Button trigger modal -->
<button
	type="button"
	class="btn btn-sm btn-purple" 
	data-bs-toggle="modal"
	data-bs-target="#exampleModal"
	on:click={clearMessage}
>
	<i class="bi bi-floppy-fill"></i>
	<span class="ms-1">SAVE</span>
</button>
<!-- Modal -->
<div
	class="modal fade"
	id="exampleModal"
	tabindex="-1"
	aria-labelledby="exampleModalLabel"
	aria-hidden="true"
>
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<div>
					<h1 class="modal-title fs-3" id="exampleModalLabel">Save JSON</h1>
				</div>
			</div>
			<div class="modal-body">
				<div class="mb-3">
					<label class="form-label" for="title">Title</label>
					<input
						class="form-control"
						bind:value={title}
						type="text"
						placeholder="Enter title for this JSON..."
					/>
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal"
					>Close</button
				>
				<button type="button" on:click={handleOnSave} class="btn btn-purple">Save changes</button>
			</div>
			{#if alert.mesage}
				<div class="m-2 alert {alert.status === 'success' ? 'alert-primary' : 'alert-danger'}">
					{alert.mesage}
				</div>
			{/if}
		</div>
	</div>
</div>

<style>
    :root {
        --bs-primary: #ff5733; /* Replace #ff5733 with your desired primary color */
    }
	.btn-purple {
		background-color: #9000ff;
		border-color: #9000ff;
		color: white;
	}
</style>
