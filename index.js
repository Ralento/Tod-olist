const express = require('express');
const app = express();

const { Pool } = require('pg');
const pool = new Pool({
  host: 'localhost',
  user: 'postgres',
  password: 'rollo200726',
  database: 'todo',
  port: 5432
});


app.use(express.static('public'));

app.listen(7000 , () => {
    console.log('Server is running on port lhttp://localhost:7000');
});
