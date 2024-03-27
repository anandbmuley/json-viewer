<script lang="ts">
	export let data: string;

	function isObject(value: any): boolean {
		return typeof value === 'object' && value !== null && !Array.isArray(value);
	}
</script>

<div class="tree-view">
	<ul>
		{#if data}
			{#each Object.entries(JSON.parse(data)) as [key, value]}
				<li>
					<i class="fas fa-caret-right"></i>
					<span class="key">{key}:</span>
					<span class="value"
						>{#if isObject(value)}
							<ul class="tree-view">
								<svelte:self data={JSON.stringify(value)} />
							</ul>
						{:else}
							{value}
						{/if}</span
					>
				</li>
			{/each}
		{:else}
			<li>No data available</li>
		{/if}
	</ul>
</div>

<style>
	/* Add your Bootstrap styles here */
	.tree-view {
		font-family: 'PT Sans';
	}
	.key {
		font-weight: 600;
	}
	.value {
	}
	.tree-view ul {
		list-style-type: none;
		padding-left: 20px;
	}
	.tree-view li {
		margin-bottom: 5px;
	}
	.tree-view li:before {
		content: '\25A0';
		display: inline-block;
		font-family: 'Font Awesome 5 Free';
		margin-right: 5px;
	}
</style>
