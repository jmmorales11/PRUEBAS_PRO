
const {Schema, model, default: mongoose}= require("mongoose")
const usersSchema= new Schema({
    firstName:{
        type: String,
        required:true
    },
    lastName:{
        type: String,
        required:true
    },
    phoneNumber:{
        type: String,
        required:true
    },
    email:{
        type: String,
        required:true,
    },
    dateBirthday:{
        type: Date,
        required:true
    },
    username:{
        type: String,
        required:true
    },
    password:{
        type: String,
        required:true
    }
});

const user=mongoose.model('User', usersSchema);
module.exports= user
