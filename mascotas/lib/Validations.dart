class Validations {
  String? validateUser(String? value) {
    if (value == null || value.isEmpty) {
      return "Username Empty";
    }
    String pattern = r'^(?=.*[a-zA-ZñÑ])(?=.*\d)[a-zA-ZñÑ\d]{6,10}$';
    RegExp regExp = RegExp(pattern);
    if (!regExp.hasMatch(value)) {
      return "El nombre debe tener entre 6 y 10 caracteres, incluir al menos una letra y un número, y no contener caracteres especiales.";
    }
    return null;
  }

  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return "El nombre está vacío.";
    }
    // Eliminar espacios al principio y al final
    value = value.trim();

    // Verificar que solo contenga letras y tenga entre 2 y 10 caracteres
    String pattern = r'^[A-Z][a-zA-ZñÑ]{1,9}$';
    RegExp regExp = RegExp(pattern);
    if (!regExp.hasMatch(value)) {
      return "El nombre debe tener entre 2 y 10 letras, y comenzar con una letra mayúscula.";
    }
    return null;
  }


  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return "La contraseña es necesaria";
    }

    if (value.length < 6) {
      return "La contraseña debe tener al menos 6 caracteres";
    }
    return null;
  }

}
