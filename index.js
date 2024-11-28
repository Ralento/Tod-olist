const express = require('express');
const session = require('express-session');
const app = express();

const { Pool } = require('pg');
const pool = new Pool({
  host: 'localhost',
  user: 'postgres',
  password: '1234',
  database: 'todo',
  port: 5432
});
// Configura EJS con delimitadores diferentes


app.use(express.static('public'));
app.use(express.json());
app.use(express.urlencoded({ extended: true }));


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
  console.log('Datos enviados por el formulario:', user, password); // Muestra los datos enviados
  pool.query('SELECT * FROM usuarios WHERE usuario = $1 AND contraseña = $2', [user, password])
    .then((data) => {
      console.log('Datos del usuario encontrado:', data.rows); // Muestra los resultados de la consulta
      if (data.rows.length > 0) {
        req.session.user = user;
        req.session.user_id = data.rows[0].usuario_id; // Cambia aquí si la columna es diferente
        console.log('Usuario autenticado, ID:', req.session.user_id); // Muestra el ID en la sesión
        res.redirect('/tareas');
      } else {
        console.log('No se encontraron coincidencias para el usuario y contraseña');
        res.render('login', { mensaje: 'Usuario o contraseña incorrectos.' });
      }
    })
    .catch((error) => {
      console.error('Error al realizar la consulta:', error); // Muestra cualquier error SQL
      res.render('login', { mensaje: 'Error al iniciar sesión.' });
    });
});


app.post('/register', async (req, res) => {
    const { name, tel, user, password } = req.body;
    pool.query('INSERT INTO usuarios (nombre, telefono, usuario, contraseña) VALUES ($1, $2, $3, $4)', [name, tel, user, password])
        .then(data => {
            res.redirect('/');
        })
        .catch(error => {
            console.log(error);
            res.render('login');
        });
});

app.get('/tareas', async(req, res) => {
  if (!req.session.user) {
      return res.redirect('/');
  }

  const userId = req.session.user_id;

pool.query('SELECT * FROM tareas WHERE usuario_asignado_id = $1 ORDER BY prioridad ASC', [userId]).then(data => {
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


app.post('/actualizar-tarea', (req, res) => {
  const { id, estado, fechaVencimiento } = req.body;

  // Asegúrate de actualizar la tarea en la base de datos
  pool.query('UPDATE tareas SET estado = ?, fecha_vencimiento = ? WHERE tarea_id = ?', 
    [estado, fechaVencimiento, id], 
    (err, result) => {
      if (err) throw err;
      res.redirect('/tareas'); // Redirige después de actualizar la tarea
    });
});




// Ruta para eliminar una tarea
app.post('/eliminar-tarea', async (req, res) => {
  const { id } = req.body;

  try {
    // Ejecutamos la consulta para eliminar la tarea por su ID
    await pool.query('DELETE FROM tareas WHERE tarea_id = $1', [id]);

    // Redirigimos a la lista de tareas después de eliminar
    res.redirect('/tareas');
  } catch (error) {
    console.error('Error al eliminar la tarea:', error);
    res.redirect('/tareas');
  }
});



app.get('/crear', (req, res) => {
  res.render('crear');
});

app.post('/crear-tarea', async (req, res) => {
  const { descripcion, estado, prioridad, fecha } = req.body; // Asegúrate de que la fecha esté llegando desde el formulario
  const userId = req.session.user_id;

  if (!userId) {
    return res.status(403).send('No estás autorizado para crear tareas.');
  }

  try {
    // Insertar la tarea con la fecha de vencimiento
    const tareaResult = await pool.query(
      'INSERT INTO tareas (descripcion, estado, prioridad, fecha_creacion, fecha_vencimiento, usuario_asignado_id) VALUES ($1, $2, $3, NOW(), $4, $5) RETURNING tarea_id',
      [descripcion, estado, prioridad, fecha, userId]  // Asegúrate de que 'fecha' es el valor recibido desde el formulario
    );

    const tareaId = tareaResult.rows[0].tarea_id;

    // Insertar en el calendario
    await pool.query(
      'INSERT INTO calendario (tarea_id, fecha, usuario_id) VALUES ($1, $2, $3)',
      [tareaId, fecha, userId]
    );

    res.redirect('/tareas');
  } catch (error) {
    console.error('Error al crear la tarea:', error);
    res.render('crear', { mensaje: 'Error al crear la tarea. Inténtalo de nuevo.' });
  }
});


app.get('/calendario', async (req, res) => {
  const userId = req.session.user_id;

  try {
    const tareas = await pool.query(
      'SELECT descripcion, fecha_vencimiento, estado FROM tareas WHERE usuario_asignado_id = $1',
      [userId]
    );

    const eventos = tareas.rows.map(tarea => ({
      title: tarea.descripcion,
      start: tarea.fecha_vencimiento,
      end: tarea.fecha_vencimiento,
      description: tarea.estado
    }));

    // Pasar los eventos al renderizado de la vista
    res.render('calendario', { eventos: eventos });
  } catch (error) {
    console.error('Error al cargar tareas:', error);
    res.render('calendario', { eventos: [] });
  }
});


app.post('/perfil', (req, res) => {
  const { name, user, password, description, tel } = req.body;
  const userId = req.session.user_id;

  pool.query(
    'UPDATE usuarios SET nombre = $1, usuario = $2, contraseña = $3, descripcion = $4, telefono = $5 WHERE usuario_id = $6',
    [name, user, password, description, tel, userId]
  )
    .then(() => {
      res.redirect('/perfil'); // Redirige a la vista del perfil actualizado
    })
    .catch(error => {
      console.error('Error al actualizar el perfil:', error);
      res.render('perfil', { mensaje: 'Error al actualizar los datos.', user: req.body });
    });
});

app.listen(7000 , () => {
    console.log('Server is running on port lhttp://localhost:7000');
});

