<script lang="ts">
	import { onMount } from 'svelte';
</script>

<div data-bs-theme="dark" class="container page-center">
	<h1 class="display-1">JSON Viewer</h1>
	<h2>Introduction</h2>
	<p>JSON viewer is helpful tool for working with JSON strings. Below are some of its features:</p>
	<ul>
		<li>
			<b>Tree View</b>
			<p>You can see a tree view of the JSON content in a user readable format.</p>
		</li>
		<li>
			<b>Saving</b>
			<p>You can save the JSON content by giving a title and refer it later.</p>
		</li>
	</ul>
	<a class="btn btn-lg btn-purple" href="/app">GET STARTED</a>
</div>

<style>
	.page-center {
		margin-left: 20%;
		margin-top: 10%;
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
