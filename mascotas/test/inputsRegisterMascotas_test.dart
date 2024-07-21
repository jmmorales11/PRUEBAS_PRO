import 'package:flutter_test/flutter_test.dart';
import 'package:mascotas/Validations.dart';

void main(){
  final Validations _validations = Validations();
  //VALIDATIONS NOMBRE MASCOTA/ RAZA/ COLOR PELAJE Only letters
  test('Valid only letters', () async{
      String? result =  _validations.validateOnlyLetters("buldog aleman siberiano uwu");
      expect(result, null);
    }
  );
  test('Invalid only letters', () async{
      String? result =  _validations.validateOnlyLetters("");
      expect(result, isNotNull);
    }
  );
  test('Invalid only letters', () async{
      String? result =  _validations.validateOnlyLetters("22222");
      expect(result, isNotNull);
    }
  );
}