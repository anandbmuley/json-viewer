<script lang="ts">
	import { onMount } from 'svelte';
</script>

<div data-bs-theme="dark" class="container page-center">
	<h1 class="display-1">JSON Viewer</h1>
	<h2>Features</h2>
	<p>JSON Viewer simplifies working with JSON data. Key features include:</p>
	<ul>
		<li><b>Tree View:</b> Visualize JSON in an easy-to-read tree structure.</li>
		<li><b>Save & Retrieve:</b> Save JSON with a title for future reference.</li>
		<li><b>Schema Validation:</b> Validate JSON against schemas and save schemas for reuse.</li>
		<li><b>JSON Path Evaluation:</b> Query the JSON tree using JSON Path expressions.</li>
		<li><b>Diff Tool:</b> Compare two JSON objects and highlight differences.</li>
		<li><b>Talk to JSON:</b> Interact with JSON data using lightweight AI model Phi-3</li>
	</ul>
	<a class="btn btn-lg btn-purple" href="/app">GET STARTED</a>
</div>

<style>
	.page-center {
		display: flex;
		flex-direction: column;
		justify-content: center;
		align-items: center;
		height: 100vh;
	}
	ul {
		text-align: left;
	}
	h1 {
		font-family: 'Arial Black';
	}
	h2,
	p {
		font-family: 'Arial';
	}
	p {
		font-size: 1.2rem;
	}
	.btn-purple {
		background-color: #9000ff;
		border-color: #9000ff;
		color: white;
	}
</style>
