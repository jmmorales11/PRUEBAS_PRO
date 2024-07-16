const mongoose = require('mongoose');

/**Crear funcion para conectar */
async function connect(){
    mongoose.connect('mongodb://localhost/sis_mas',{
        useNewUrlParser: true,
        
    });
    console.log('Database conectado');
};

module.exports = { connect };