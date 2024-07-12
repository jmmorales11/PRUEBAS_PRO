
const {Schema, model, default: mongoose}= require("mongoose")
const imgSchema= new Schema({
    mascota:{
        type: String,
        required:true
    },
    privacidad:{
        type: String,
        required:true
    },
    imagen:{
        type: String,
        required:true
    }
});

const img=mongoose.model('IMG', imgSchema);
module.exports= img
