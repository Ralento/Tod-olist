const express = require('express');
const session = require('express-session');
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
app.use(express.json());
app.use(express.urlencoded({ extended: true }));
app.set('view engine', 'ejs');


app.use(session({
  secret: 'roy',
  resave: false,
  saveUninitialized: true,
}))


app.get('/', (req, res) => {
    res.render('login');
});
app.post('/login', (req, res) => {
  const { user, password } = req.body;
  pool.query('SELECT * FROM usuarios WHERE usuario = $1 AND contraseña = $2', [user, password])
    .then((data) => {
      console.log('Datos del usuario encontrado:', data.rows); // Muestra el resultado de la consulta
      if (data.rows.length > 0) {
        req.session.user = user;
        req.session.user_id = data.rows[0].id; // Captura el ID
        console.log('Usuario autenticado, ID:', req.session.user_id); // Log del ID
        res.redirect('/tareas');
      } else {
        res.render('login', { mensaje: 'Usuario o contraseña incorrectos.' });
      }
    })
    .catch((error) => {
      console.error('Error al realizar la consulta:', error);
      res.render('login', { mensaje: 'Error al iniciar sesión.' });
    });
});

app.post('/register', (req, res) => {
    const { name, phone, user, password } = req.body;
    pool.query('INSERT INTO usuarios (nombre, telefono, usuario, contraseña) VALUES ($1, $2, $3, $4)', [name, phone, user, password])
        .then(data => {
            res.redirect('/login');
        })
        .catch(error => {
            console.log(error);
            res.render('login');
        });
});

app.get('/tareas', (req, res) => {
  if (!req.session.user) {
      return res.redirect('/');
  }

  const userId = req.session.user_id; // Asegúrate de que el user_id se almacene en la sesión al iniciar sesión

  pool.query('SELECT * FROM tareas WHERE usuario_asignado_id = $1 ORDER BY prioridad ASC', [userId])
      .then(data => {
          const tareas = data.rows;
          if (tareas.length === 0) {
              return res.render('tareas', { mensaje: 'No hay tareas registradas.', tareas: [] });
          }
          res.render('tareas', { tareas });
      })
      .catch(error => {
          console.log(error);
          res.render('tareas', { mensaje: 'Error al obtener las tareas.', tareas: [] });
      });
});

app.post('/crear-tarea', (req, res) => {
  const { descripcion, estado, prioridad } = req.body;
  const userId = req.session.user_id; // Asegúrate de que el usuario esté autenticado

  console.log('Descripción:', descripcion);
  console.log('Estado:', estado);
  console.log('Prioridad:', prioridad);
  console.log('ID de Usuario:', userId);

  if (!userId) {
      return res.status(403).send('No estás autorizado para crear tareas.');
  }

  pool.query('INSERT INTO tareas (descripcion, estado, prioridad, fecha_creacion, usuario_asignado_id) VALUES ($1, $2, $3, NOW(), $4)', 
  [descripcion, estado, prioridad, userId])
  .then(data => {
      res.redirect('/tareas'); // Redirige a la lista de tareas después de crear
  })
  .catch(error => {
      console.log(error);
      res.render('crear', { mensaje : 'Error al crear la tarea. Inténtalo de nuevo.' });
  });
});

app.get('/calendario', (req, res) => {
  res.render('calendario');
});

app.get('/crear', (req, res) => {
  res.render('crear');
});

app.get('/perfil', (req, res) => {
  res.render('perfil');
});







app.listen(7000 , () => {
    console.log('Server is running on port lhttp://localhost:7000');
});
