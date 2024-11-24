// db.js
const mysql = require('mysql2');
const express = require('express');
const app = express();


// Configura los parámetros de conexión
const connection = mysql.createConnection({
  host: 'localhost', // Cambia a la IP o dominio de tu base de datos si no es local
  user: 'root',
  password: '',
  database: 'to-do'
});

// Conectar a la base de datos
connection.connect((err) => {
  if (err) {
    console.error('Error de conexión:', err.stack);
    return;
  }
  console.log('Conectado a la base de datos MySQL');
});

module.exports = connection;



app.listen(3002, () => {
  console.log('Servidor corriendo en http://localhost:3002');
});