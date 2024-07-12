const express = require('express');
const app = express();
const morgan = require('morgan');
const cors = require('cors');
const mascotaRoutes = require('./routes/mascotas'); // Importa tus rutas
const users = require('./routes/users'); // Importa tus rutas
const img = require('./routes/img');
// Middlewares
app.use(morgan('dev'));
app.use(cors());
app.use(express.json()); // Este debe ir antes de tus rutas

// Rutas
app.use('/bmpr', mascotaRoutes);
app.use('/bmpr', users);
app.use('/bmpr', img); // Prefijo para tus rutas

module.exports = app;
