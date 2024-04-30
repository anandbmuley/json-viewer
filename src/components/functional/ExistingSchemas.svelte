<script lang="ts">
	import { db } from '$lib/db';
	import { selectedSchema } from '$lib/store';
	import { liveQuery } from 'dexie';
	import { onMount } from 'svelte';

	let selectedJson = '';

	let existingSchemas = liveQuery(() => db.schemas.toArray());
	let jsonData = '';
	let message = '';

	$: if (selectedJson) {
		try {
			$existingSchemas.forEach((item) => {
				if (item.title === selectedJson) {
					const matchingJSON = item.content;
					const parsed = JSON.parse(matchingJSON);
					jsonData = JSON.stringify(parsed, null, 2);
					selectedSchema.set(jsonData);
				}
			});
		} catch (err) {
			message = 'Invalid JSON';
		}
	}
</script>

<div>
	<div class="autocomplete">
		<input
			class="form-control form-control-sm"
			list="schemaOptions"
			id="exampleDataList"
			placeholder="Existing schemas..."
			bind:value={selectedJson}
		/>
		<button
			class="btn btn-sm bi bi-x-circle"
			data-toggle="tooltip"
			data-placement="top"
			title="Clear selection"
		></button>
	</div>
	<datalist id="schemaOptions">
		{#if $existingSchemas}
			{#each $existingSchemas as item (item.id)}
				<option value={item.title} />
			{/each}
		{/if}
	</datalist>
</div>

<style>
	.autocomplete {
		display: flex;
		flex-direction: row;
		align-content: space-between;
	}
</style>
