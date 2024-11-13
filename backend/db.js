// db.js
const mysql = require('mysql2');

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
