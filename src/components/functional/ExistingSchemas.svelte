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
	<input
		class="form-control form-control-md"
		list="schemaOptions"
		id="exampleDataList"
		placeholder="Existing schemas..."
		bind:value={selectedJson}
		type="search"
	/>
	<datalist id="schemaOptions">
		{#if $existingSchemas}
			{#each $existingSchemas as item (item.id)}
				<option value={item.title} />
			{/each}
		{/if}
	</datalist>
</div>
