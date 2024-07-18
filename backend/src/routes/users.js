const { Router } = require('express');
const router = Router();
const User = require('../models/Users');

// Get all users
router.get('/users', async (req, res) => {
    try {
        const users = await User.find();
        res.json({ users });
    } catch (error) {
        console.error("error user", error);
        res.status(500).json({ error: "error" });
    }
});

// Add a new user
router.post('/users/create', async (req, res) => {
    try {
        const newUser = new User(req.body);
        await newUser.save();
        res.json({ message: 'User added successfully', user: newUser });
    } catch (error) {
        console.error("error add user", error);
        res.status(500).json({ error: "Error adding user" });
    }
});

module.exports = router;
