import 'RegisterUsers/ApiServices_Users.dart';

class Validations {
  late List userData = [];

  Validations() {
    getUsers();
  }

  Future<void> getUsers() async {
    final List<dynamic> users = await ApiService.getUsers();
    userData = users;
  }

  // VALIDA USUARIO DE PERSONAS
  // verificamos solo ingreso de letras y números de 5 a 10 caracteres
  String? validateUser(String? value) {
    if (value == null || value.isEmpty) {
      return "Username cannot be empty";
    }
    value = value.trim();
    if (!RegExp(r'^[a-zA-Z0-9]{5,10}$').hasMatch(value)) {
      return "Only letters and numbers, between 5 to 10 characters.";
    }
    return null;
  }

  // VALIDA SI EL USUARIO EXISTE
  Future<String?> validateUserExists(String? value) async {
    if (value == null || value.isEmpty) {
      return "Username cannot be empty";
    }
    await getUsers();
    for (var user in userData) {
      if (user['username'] == value) {
        return "Username already exists";
      }
    }
    return null;
  }


  //VALIDA NOMBRE DE PERSONAS
// Verificar que solo contenga letras y tenga entre 2 y 10 caracteres
  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return "Name cannot be empty";
    }
    value = value.trim();

    // Verificar que solo contenga letras y tenga entre 2 y 10 caracteres
    String pattern = r"^[A-ZÁÉÍÓÚÜÑ][a-záéíóúüñA-ZÁÉÍÓÚÜÑ]{1,9}$";
    RegExp regExp = RegExp(pattern);
    if (!regExp.hasMatch(value)) {
      return "Only letters, between 2 to 10 characters, and the first letter must be capitalized.";
    }
    return null;
  }


  //VALIDA CONTRASEÑA
  //Ingresa lo que quiera, minimo 6 caracteres
  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Password cannot be empty";
    }

    if (value.length < 6) {
      return "Minimun 6 characteres";
    }
    return null;
  }


  //VALIDA EMAL
  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return "Email cannot be empty";
    }
    value = value.trim();

    String pattern =
        r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
    RegExp regExp = RegExp(pattern);
    if (!regExp.hasMatch(value)) {
      return "Invalid email format";
    }
    return null;
  }


  //VALIDA NÚMERO TELEFÓNICO DE PERSONAS,
  String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return "Phone number cannot be empty";
    }
    value = value.trim();

    String pattern = r'^09\d{8}$';
    RegExp regExp = RegExp(pattern);
    if (!regExp.hasMatch(value)) {
      return "Invalid Ecuadorian phone number format";
    }
    return null;
  }

  //VALIDAR CONTRASEÑA SIMILAR
  String? validatePasswordEquals(String? value, String? originalPassword) {
    if (value == null || value.isEmpty) {
      return "Password confirmation cannot be empty";
    }
    if (value != originalPassword) {
      return "Passwords do not match";
    }
    return null;
  }


  /*------------------------------------------------------------------------------------*/
//VALIDACIONES MASCOTAS FORMULARIOS
// VALIDA NOMBRE MASCOTA/ RAZA/ COLOR PELAJE
  String? validateOnlyLetters(String? value) {
    if (value == null || value.isEmpty) {
      return "Name cannot be empty";
    }
    value = value.trim();

    // Expresión regular para permitir letras (con tildes), números y espacios, pero no caracteres especiales
    String pattern = r"^[A-Za-zÁÉÍÓÚÜÑáéíóúüñ0-9\s]+$";
    RegExp regExp = RegExp(pattern);
    if (!regExp.hasMatch(value)) {
      return "Only letters (including tildes), numbers, and spaces are allowed.";
    }
    return null;
  }


  String? validateDescription(String? value) {
    if (value == null || value.isEmpty) {
      return "        Name cannot be empty";
    }
    value = value.trim();
    return null;
  }
}


