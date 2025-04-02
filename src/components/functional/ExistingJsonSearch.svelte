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
	} else {
		jsonData = ''; // Clear jsonData when input is cleared
		selectedJSON.set(''); // Ensure the store is cleared to reflect in the textarea
	}
</script>

<div>
	<div>
		<input
			class="form-control form-control-md"
			list="datalistOptions"
			id="exampleDataList"
			placeholder="Existing jsons..."
			bind:value={selectedJson}
			type="search"
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
