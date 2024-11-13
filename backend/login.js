
const mysql = require("./db");

async function insertar(nombre, email, rol) {
    const params = [nombre, email, rol]
    const res = await mysql.query('INSERT INTO usuarios WHERE nombre = ?, email = ?, rol = ?', params);
}