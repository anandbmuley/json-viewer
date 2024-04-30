<script lang="ts">
	import type { Alert } from '$lib/ViewModel';
	import FieldValue from './FieldValue.svelte';

	export let data: string;
	let alert: Alert = {
		mesage: '',
		status: 'success'
	};

	function isObject(value: any): boolean {
		return typeof value === 'object' && value !== null && !Array.isArray(value);
	}

	function isArray(value: any): boolean {
		return Array.isArray(value);
	}

	function toArray(value: any): any[] {
		return value as any[];
	}

	function parseJSON(data: string) {
		try {
			alert = {
				mesage: '',
				status: 'success'
			};
			console.info('Parsing JSON', data);
			return JSON.parse(data);
		} catch (err) {
			alert = {
				mesage: `JSON parsing failed: ${err}`,
				status: 'error'
			};
			return '';
		}
	}
</script>

<div class="tree-view">
	{#if alert.mesage && data}
		<p class={alert.status === 'success' ? 'text-success' : 'text-danger'}>{alert.mesage}</p>
	{/if}
	<ul>
		{#if data}
			{#each Object.entries(parseJSON(data)) as [key, value]}
				<li>
					<i class="fas fa-caret-right"></i>
					<span class="key">{key}:</span>
					<span class="value"
						>{#if isObject(value)}
							<ul class="tree-view">
								<svelte:self data={JSON.stringify(value)} />
							</ul>
						{:else if isArray(value)}
							<ul class="tree-view">
								{#each toArray(value) as item, index}
									{#if typeof item === 'string' || typeof item === 'number' || typeof item === 'boolean'}
										<li>
											<FieldValue value={item} />
										</li>
									{:else}
										<svelte:self data={JSON.stringify(item)} />
									{/if}
								{/each}
							</ul>
						{:else}
							<FieldValue {value} />
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
