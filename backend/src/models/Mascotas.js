
const {Schema, model, default: mongoose}= require("mongoose")
const mascotaSchema= new Schema({
    nombre_mas:{
        type: String,
        required:true
    },
    raza:{
        type: String,
        required:true
    },
    sexo:{
        type: String,
        required:true
    },
    fecha_nac:{
        type: String,
        required:true
    },
    color_pelaje:{
        type: String,
        required:true
    },
    tipo:{
        type: String,
        required:true
    },
    privacidad:{
        type: String,
        required:true
    },
    descripcion:{
        type: String,
        required:true
    },
    user:{
        type: String,
        required:true
    }
});

const mascotas=mongoose.model('Mascotas', mascotaSchema);
module.exports= mascotas
