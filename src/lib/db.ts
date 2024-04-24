import Dexie, { type Table } from 'dexie';

const DB_NAME = "JsonViewer";

export interface Schema {
    id?: number;
    title: string;
    content: string;
}

export interface Json {
    id?: number;
    title: string;
    content: string;
}

export class MySubClassDexie extends Dexie {
    schemas!: Dexie.Table<Schema, number>;
    jsons!: Dexie.Table<Json, number>;

    constructor() {
        super(DB_NAME);
        this.version(1).stores({
            schemas: "++id, title, content",
            jsons: "++id, title, content"
        });
    }
}

export const db = new MySubClassDexie();