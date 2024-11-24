const mysql = require('mysql2');
const express = require('express');
const bodyParser = require('body-parser');
const bcrypt = require('bcrypt');
const path = require('path'); // Para trabajar con rutas
const app = express();

// Middleware para parsear el cuerpo de las solicitudes
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true })); // Para manejar formularios URL-encoded

// Configura EJS como motor de plantillas
app.set('view engine', 'ejs');
app.set('views', path.join(__dirname, 'views')); // Carpeta donde estarán tus vistas
app.use(express.static(path.join(__dirname, 'public')));

// Configura los parámetros de conexión
const connection = mysql.createConnection({
  host: 'localhost',
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

// Ruta para mostrar el formulario de inicio de sesión
app.get('/', (req, res) => {
  res.render('login'); // Renderiza la vista 'login.ejs'
});

// Ruta para registrarse
app.post('/register', (req, res) => {
  const { name, phone, email, password } = req.body;

  // Verificar si el email ya está registrado
  connection.query('SELECT * FROM usuarios WHERE email = ?', [email], (error, results) => {
    if (error) {
      return res.status(500).send('Error en la base de datos');
    }

    if (results.length > 0) {
      return res.status(400).send('El email ya está registrado');
    }

    // Hash de la contraseña antes de almacenarla
    bcrypt.hash(password, 10, (err, hash) => {
      if (err) {
        return res.status(500).send('Error al registrar el usuario');
      }

      // Insertar el nuevo usuario en la base de datos
      connection.query('INSERT INTO usuarios (nombre, email, telefono, contraseña) VALUES (?, ?, ?, ?)', 
      [name, phone, email, hash], (error) => {
        if (error) {
          return res.status(500).send('Error al registrar el usuario');
        }
        res.status(201).send('Registro exitoso');
      });
    });
  });
});

// Ruta para iniciar sesión
app.post('/login', (req, res) => {
  const { email, password } = req.body;

  // Verificar si el usuario existe
  connection.query('SELECT * FROM usuarios WHERE email = ?', [email], (error, results) => {
    if (error) {
      return res.status(500).send('Error en la base de datos');
    }

    if (results.length > 0) {
      const user = results[0];
      // Comparar la contraseña ingresada con la almacenada (hash)
      bcrypt.compare(password, user.contraseña, (err, match) => {
        if (match) {
          res.status(200).send('Login exitoso');
        } else {
          res.status(401).send('Email o contraseña incorrectos');
        }
      });
    } else {
      res.status(401).send('Email o contraseña incorrectos');
    }
  });
});

// Iniciar el servidor
app.listen(3002, () => {
  console.log('Servidor corriendo en http://localhost:3002');
});