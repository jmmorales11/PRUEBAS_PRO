
const {Schema, model, default: mongoose}= require("mongoose")
const usersSchema= new Schema({
    usuario:{
        type: String,
        required:true
    },
    contrasena:{
        type: String,
        required:true
    },
    correo:{
        type: String,
        required:true
    }
});

const user=mongoose.model('User', usersSchema);
module.exports= user
