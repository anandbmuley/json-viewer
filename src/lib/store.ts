import { writable } from 'svelte/store';

export const selectedJSON = writable('');
export const selectedSchema = writable('');

export const jsonSchemaStored = writable('');
export const jsonInputStored = writable('');
