const mongoose = require('mongoose');

/**Crear funcion para conectar */
async function connect(){
    mongoose.connect('mongodb+srv://adminPizza:6i82PjLNVh9Xt4M@pizzeria.dwwqof4.mongodb.net/?retryWrites=true&w=majority&appName=Pizzeria',{
        useNewUrlParser: true,
        
    });
    console.log('Database conectado');
};

module.exports = { connect };