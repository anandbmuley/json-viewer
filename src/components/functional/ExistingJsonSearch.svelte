<script lang="ts">
	import { db } from '$lib/db';
	import { selectedJSON } from '$lib/store';
	import { liveQuery } from 'dexie';

	let selectedJson = '';

	let existingJsons = liveQuery(() => db.jsons.toArray());
	let jsonData = '';
	let message = '';

	$: if (selectedJson) {
		try {
			$existingJsons.forEach((item) => {
				if (item.title === selectedJson) {
					const matchingJSON = item.content;
					const parsed = JSON.parse(matchingJSON);
					jsonData = JSON.stringify(parsed, null, 2);
					selectedJSON.set(jsonData);
				}
			});
		} catch (err) {
			message = 'Invalid JSON';
		}
	}
</script>

<div class="col-6 mt-1 ms-3" data-bs-theme="light">
	<div>
		<input
			class="form-control form-control-sm"
			list="datalistOptions"
			id="exampleDataList"
			placeholder="Existing jsons..."
			bind:value={selectedJson}
		/>
	</div>
	<datalist id="datalistOptions">
		{#if $existingJsons}
			{#each $existingJsons as item (item.id)}
				<option value={item.title} />
			{/each}
		{/if}
	</datalist>
</div>
