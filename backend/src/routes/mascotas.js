const { Router } = require('express');
const Mascotas = require('../models/Mascotas');
const router = Router();

// Obtener lista de mascotas
router.get('/mascotas', async (req, res) => {
    try {
        const mascotas = await Mascotas.find();
        res.json(mascotas);
    } catch (error) {
        console.error("Error al obtener mascotas: ", error);
        res.status(500).json({ error: "Error al obtener mascotas" });
    }
});

// Crear una mascota con datos enviados en la solicitud
router.post('/mascotas/crear', async (req, res) => {
    const { nombre_mas, raza, sexo, fecha_nac, color_pelaje, tipo, privacidad, descripcion, user } = req.body;

    try {
        const nuevaMascota = new Mascotas({
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
        await nuevaMascota.save();
        res.json({ message: 'Mascota creada exitosamente' });
    } catch (error) {
        console.error("Error al crear mascota: ", error);
        res.status(500).json({ error: "Error al crear mascota" });
    }
});

module.exports = router;
