const { Router } = require('express');
const router = Router();
const User = require('../models/Users');

// Obtener lista de usuarios
router.get('/users', async (req, res) => {
    try {
        const users = await User.find();
        res.json(users);
    } catch (error) {
        console.error("Error user: ", error);
        res.status(500).json({ error: "Error" });
    }
});



// Crear un usuario con datos enviados en la solicitud
router.post('/users/create', async (req, res) => {
    const { usuario, contrasena, correo } = req.body;

    try {
        await User.create({
            usuario,
            contrasena,
            correo
        });
        res.json({ message: 'Usuario creado' });
    } catch (error) {
        console.error("Error creating user: ", error);
        res.status(500).json({ error: "Error creating user" });
    }
});


module.exports = router;
