<script lang="ts">
	import { onMount } from 'svelte';

	export let jsonData: string = '';
	let jsonPath: string = '';
	let result: string = 'Enter a JSON Path and click Apply to see the result.';

	onMount(() => {
		if (window.jsonpath) {
			console.log('jsonpath library is available via CDN.');
		} else {
			console.error('jsonpath library is not available.');
		}
	});

	const applyJsonPath = () => {
		try {
			const parsedData = JSON.parse(jsonData);
			result = JSON.stringify(window.jsonpath.query(parsedData, jsonPath), null, 2); // Access jsonpath from window
		} catch (err) {
			console.error(err);
			result = 'Invalid JSON or JSON Path';
		}
	};

	$: isJsonDataAvailable = jsonData.trim().length > 0;
</script>

<div class="d-flex flex-column h-100">
	{#if !isJsonDataAvailable}
		<p class="text-muted">Enter JSON content in the viewer to enable JSON Path evaluation.</p>
	{/if}
	<div class="input-group mb-2">
		<input
			type="text"
			class="form-control me-2"
			bind:value={jsonPath}
			placeholder="Enter JSON Path..."
			disabled={!isJsonDataAvailable}
		/>
		<button class="btn btn-sm btn-purple" on:click={applyJsonPath} disabled={!isJsonDataAvailable}>Apply</button>
	</div>
	<div class="flex-grow-1 overflow-auto">
		<pre>{result}</pre>
	</div>
</div>

<style>
	pre {
		background-color: #f8f9fa;
		padding: 10px;
		border: 1px solid #dee2e6;
		border-radius: 4px;
		white-space: pre-wrap;
		word-wrap: break-word;
	}
	.btn-purple {
		background-color: #9000ff;
		border-color: #9000ff;
		color: white;
	}
	.text-muted {
		color: #6c757d;
		font-size: 0.9rem;
	}
</style>
