<script lang="ts">
	import { createEventDispatcher } from 'svelte';

	export let values: string[] = [];
	const dispatch = createEventDispatcher();

	let selectedValue: string;

	$: if (selectedValue) {
		dispatch('select', {
			current: selectedValue
		});
	}
</script>

<div class="form-group">
	<label for="input-datalist">Timezone</label>
	<input
		type="text"
		class="form-control"
		placeholder="Timezone"
		list="list-timezone"
		id="input-datalist"
		bind:value={selectedValue}
	/>
	<datalist id="list-timezone">
		{#each values as value}
			<option {value}>{value}</option>
		{/each}
	</datalist>
</div>
