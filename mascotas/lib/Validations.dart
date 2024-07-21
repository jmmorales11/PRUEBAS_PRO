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
      return "El nombre de usuario no puede estar vacío";
    }
    value = value.trim();
    if (!RegExp(r'^[a-zA-Z0-9]{5,10}$').hasMatch(value)) {
      return "Sólo letras y números, entre 5 y 10 caracteres.";
    }
    return null;
  }

  // VALIDA SI EL USUARIO EXISTE
  Future<String?> validateUserExists(String? value) async {
    if (value == null || value.isEmpty) {
      return "El nombre de usuario no puede estar vacío";
    }
    await getUsers();
    for (var user in userData) {
      if (user['username'] == value) {
        return "El nombre de usuario ya existe";
      }
    }
    return null;
  }

  //VALIDA NOMBRE DE PERSONAS
// Verificar que solo contenga letras y tenga entre 2 y 10 caracteres
  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return "El nombre no puede estar vacío";
    }
    value = value.trim();

    // Verificar que solo contenga letras y tenga entre 2 y 10 caracteres
    String pattern = r"^[A-ZÁÉÍÓÚÜÑ][a-záéíóúüñA-ZÁÉÍÓÚÜÑ]{1,9}$";
    RegExp regExp = RegExp(pattern);
    if (!regExp.hasMatch(value)) {
      return "Sólo letras, entre 2 y 10 caracteres,\n y la primera letra debe ir en mayúscula.";
    }
    return null;
  }

  //VALIDA CONTRASEÑA
  //Ingresa lo que quiera, minimo 6 caracteres
  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return "La contraseña no puede estar vacía";
    }

    if (value.length < 6) {
      return "Mínimo 6 caracteres";
    }
    return null;
  }

  //VALIDA EMAL
  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return "El correo electrónico no \npuede estar vacío";
    }
    value = value.trim();

    String pattern = r'^[a-zA-Z][\w-\.]*@([\w-]+\.)+[\w-]{2,4}$';
    RegExp regExp = RegExp(pattern);
    if (!regExp.hasMatch(value)) {
      return "Formato de correo electrónico no válido";
    }
    return null;
  }

  //VALIDA NÚMERO TELEFÓNICO DE PERSONAS,
  String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return "El número de teléfono no puede estar vacío";
    }
    value = value.trim();

    String pattern = r'^09\d{8}$';
    RegExp regExp = RegExp(pattern);
    if (!regExp.hasMatch(value)) {
      return "Formato de número de teléfono \necuatoriano no válido";
    }
    return null;
  }

  //VALIDAR CONTRASEÑA SIMILAR
  String? validatePasswordEquals(String? value, String? originalPassword) {
    if (value == null || value.isEmpty) {
      return "La confirmación de contraseña\n no puede estar vacía";
    }
    if (value != originalPassword) {
      return "Las contraseñas no coinciden";
    }
    return null;
  }

  /*------------------------------------------------------------------------------------*/
//VALIDACIONES MASCOTAS FORMULARIOS
// VALIDA NOMBRE MASCOTA/ RAZA/ COLOR PELAJE
  String? validateOnlyLetters(String? value) {
    if (value == null || value.isEmpty) {
      return "El nombre no puede estar vacío";
    }
    value = value.trim();

    // Expresión regular para permitir letras (con tildes), números y espacios, pero no caracteres especiales
    String pattern = r"^[A-Za-zÁÉÍÓÚÜÑáéíóúüñ\s]+$";
    RegExp regExp = RegExp(pattern);
    if (!regExp.hasMatch(value)) {
      return "Sólo se permiten letras (incluidas las tildes)\n, números y espacios.";
    }
    return null;
  }

  String? validateDescription(String? value) {
    if (value == null || value.isEmpty) {
      return "El nombre no puede estar vacío";
    }
    value = value.trim();
    return null;
  }
}
