import {Pool} from 'pg';

const pool = new Pool({
    host: 'localhost',
    port: '5432',
    user: 'postgres',
    password: 'password',
    database: 'pevn'
});

module.exports = pool;