const { Router } = require('express');
const router = Router();
const Mascotas = require('../models/Mascotas');

// Obtener lista de usuarios
router.get('/mascotas', async (req, res) => {
    try {
        const mascota = await Mascotas.find();
        res.json(mascota);
    } catch (error) {
        console.error("Error user: ", error);
        res.status(500).json({ error: "Error" });
    }
});



// Crear un usuario con datos enviados en la solicitud
router.post('/mascotas/crear', async (req, res) => {
    const { nombre_mas, raza, sexo, fecha_nac, color_pelaje, tipo,  privacidad,  descripcion,user } = req.body;

    try {
        await Mascotas.create({
            nombre_mas,
            raza,
            sexo,
            fecha_nac,
            color_pelaje,
            tipo,
            privacidad,
            descripcion,
            user
        });
        res.json({ message: 'Crear usuario' });
    } catch (error) {
        console.error("Error creating user: ", error);
        res.status(500).json({ error: "Error creating user" });
    }
});

module.exports = router;