const { Router } = require('express');
const router = Router();
const IMG = require('../models/Imagenes');

// Obtener lista de usuarios
router.get('/img', async (req, res) => {
    try {
        const users = await IMG.find();
        res.json(users);
    } catch (error) {
        console.error("Error user: ", error);
        res.status(500).json({ error: "Error" });
    }
});



// Crear un usuario con datos enviados en la solicitud
router.post('/img/crear', async (req, res) => {
    const { mascota, privacidad, imagen } = req.body;

    try {
        await IMG.create({
            mascota,
            privacidad,
            imagen
        });
        res.json({ message: 'Imagen insertada' });
    } catch (error) {
        console.error("Error creating user: ", error);
        res.status(500).json({ error: "Error creating user" });
    }
});


module.exports = router;
