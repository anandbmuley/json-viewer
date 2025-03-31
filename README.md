# create-svelte

Everything you need to build a Svelte project, powered by [`create-svelte`](https://github.com/sveltejs/kit/tree/main/packages/create-svelte).

## Creating a project

If you're seeing this, you've probably already done this step. Congrats!

```bash
# create a new project in the current directory
npm create svelte@latest

# create a new project in my-app
npm create svelte@latest my-app
```

## Developing

Once you've created a project and installed dependencies with `npm install` (or `pnpm install` or `yarn`), start a development server:

```bash
npm run dev

# or start the server and open the app in a new browser tab
npm run dev -- --open
```

## Building

To create a production version of your app:

```bash
npm run build
```

You can preview the production build with `npm run preview`.

> To deploy your app, you may need to install an [adapter](https://kit.svelte.dev/docs/adapters) for your target environment.

## Release Notes

### Version 1.2.0

### New Features

- Added functionality to validate JSON schemas and inputs.
- Introduced a "Tree View" for better visualization of JSON data.
- Implemented a feature to evaluate JSON paths for quick data extraction.

### Improvements

- Enhanced the user interface for JSON input and schema validation.
- Improved responsiveness and layout for better usability on different screen sizes.
- Optimized the JSON viewer for handling larger datasets.

### Fixes

- Resolved an issue where the JSON schema input was not clearing properly on component load.
- Fixed a bug causing incorrect synchronization between selected JSON and schema inputs.
- Addressed minor UI inconsistencies in the validator and viewer components.

### Miscellaneous

- Updated the search functionality for existing schemas to improve accuracy.
- Improved error messages for invalid JSON inputs to provide clearer feedback.
