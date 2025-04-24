<script lang="ts">
	import { page } from '$app/stores';
	import { derived } from 'svelte/store';
	import { goto } from '$app/navigation';

	const currentPath = derived(page, ($page) => $page.url.pathname);
</script>

<nav class="navbar navbar-expand-lg navbar-highlight">
	<div class="container-fluid">
		<a class="navbar-brand app-name" href="/">JSON Viewer</a>
		<button
			class="navbar-toggler"
			type="button"
			data-bs-toggle="collapse"
			data-bs-target="#navbarNav"
			aria-controls="navbarNav"
			aria-expanded="false"
			aria-label="Toggle navigation"
		>
			<span class="navbar-toggler-icon"></span>
		</button>
		<div class="collapse navbar-collapse" id="navbarSupportedContent">
			<ul class="navbar-nav me-auto mb-2 mb-lg-0">
				<li class="nav-item text-center">
					<a
						class="nav-link menu-item"
						href="/app"
						class:active={$currentPath === '/app'}
					>
						<i class="bi bi-eye"></i>
						<span>Viewer</span>
					</a>
				</li>
				<li class="nav-item text-center">
					<a
						class="nav-link menu-item"
						href="/app/validator"
						class:active={$currentPath === '/app/validator'}
					>
						<i class="bi bi-check-circle"></i>
						<span>Validator</span>
					</a>
				</li>
				<li class="nav-item text-center">
					<a
						class="nav-link menu-item"
						href="/app/diff"
						class:active={$currentPath === '/app/diff'}
					>
						<i class="bi bi-arrow-left-right"></i>
						<span>JSON Diff</span>
					</a>
				</li>
				<li class="nav-item text-center">
					<a
						class="nav-link menu-item"
						href="/app/talk-to-json"
						class:active={$currentPath === '/app/talk-to-json'}
					>
						<i class="bi bi-chat-dots"></i>
						<span>Talk to JSON</span>
					</a>
				</li>
			</ul>
		</div>
	</div>
</nav>
<slot />

<style>
	.navbar-highlight {
		background-color: #eaeaea; /* Light gray background for better visibility */
		box-shadow: 0 4px 6px rgba(0, 0, 0, 0.2); /* Add a subtle shadow for emphasis */
	}
	.menu-item {
		color: black;
		font-weight: bold;
	}
	.menu-item.active {
		color: #9000ff;
		text-decoration: underline;
		text-decoration-color: #9000ff;
		text-decoration-thickness: 2px;
		text-underline-offset: 5px; /* Increase the gap between the underline and the text */
	}
	.app-name {
		color: black;
		font-family: 'Arial Black';
		font-size: 2rem;
	}
</style>

