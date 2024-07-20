import 'dart:convert';
import 'dart:io' as io;

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mascotas/Login/LoginPage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Validations.dart';
import 'ApiServices_Users.dart';
import 'package:image/image.dart' as img;


class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();
  TextEditingController _dateController = TextEditingController();


  final _formKey = GlobalKey<FormState>();
  final Validations _validations = Validations();

  late Map data;
  late List userData = [];

  String? _nameError;
  String? _lastNameError;
  String? _phoneNumberError;
  String? _emailError;
  String? _usernameError;
  String? _passwordError;
  String? _confirmPasswordError;

  bool _isObscured = true;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != DateTime.now()) {
      setState(() {
        _dateController.text = picked.toString().substring(0, 10);
      });
    }
  }

  /*MANJEO DE INSERTAR IMAGEN*/
  io.File? _image;
  String? imagePath;
  String? imageBase64; // Variable para almacenar la imagen en base64
  final ImagePicker _picker = ImagePicker();

  Future<void> _openCamera() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        _image = io.File(pickedFile.path);
        imagePath = pickedFile.path;
      });
      _saveImagePath(pickedFile.path);
    }
  }

  Future<void> _openGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = io.File(pickedFile.path);
        imagePath = pickedFile.path;
      });
      _saveImagePath(pickedFile.path);
    }
  }

  Future<void> _saveImagePath(String path) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('imagePath', path);
  }

  Future<void> _loadImagePath() async {
    final prefs = await SharedPreferences.getInstance();
    final path = prefs.getString('imagePath');
    if (path != null) {
      setState(() {
        imagePath = path;
        if (kIsWeb) {
          _image = io.File(path);
        }
      });
    }
  }

  void _showImageSourceActionSheet(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Seleccione una opción'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.camera),
                title: Text('Abrir cámara'),
                onTap: () {
                  Navigator.of(context).pop();
                  _openCamera();
                },
              ),
              ListTile(
                leading: Icon(Icons.photo_album),
                title: Text('Abrir galería'),
                onTap: () {
                  Navigator.of(context).pop();
                  _openGallery();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  /*--------------------------------------------------------------------------*/


  @override
  void initState() {
    super.initState();
    _loadImagePath();
    getUsers();
  }

  Future<void> getUsers() async {
    final List<dynamic> users = await ApiService.getUsers(); // Obtener una lista de usuarios
    setState(() {
      userData = users;
    });
  }


  //TRANSFORMAR LA IMAGEN A BASE64
  Future<void> _convertImageToBase64() async {
    if (_image != null) {
      List<int> imageBytes = await _image!.readAsBytes();
      Uint8List uint8ImageBytes = Uint8List.fromList(imageBytes);
      img.Image? image = img.decodeImage(uint8ImageBytes);

      if (image != null) {
        img.Image resizedImage = img.copyResize(image, width: 600);
        List<int> compressedImageBytes = img.encodeJpg(resizedImage, quality: 50);
        imageBase64 = base64Encode(compressedImageBytes);

        print("Imagen en Base64: ${imageBase64!.substring(0, 100)}..."); // Imprime solo los primeros 100 caracteres
      }
    }
  }

  void _showAlertDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Color.fromARGB(240, 22, 61, 96),
          title: Text(title, style: TextStyle(color: Colors.white),),
          content: Text(message, style: TextStyle(color: Colors.white)),
          actions: <Widget>[
            TextButton(
              child: Text('Ok', style: TextStyle(color: Colors.white)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF19173d),
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Container(
          decoration: BoxDecoration(
            gradient: RadialGradient(
              center: Alignment.bottomRight,
              radius: 3.5,
              colors: [
                const Color.fromARGB(240, 22, 61, 96),
                const Color.fromARGB(255, 25, 23, 61),
                const Color.fromARGB(255, 25, 23, 61),
                const Color.fromARGB(255, 25, 23, 61),
                const Color.fromARGB(240, 25, 23, 61),
              ],
            ),
          ),
          child: Center(
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Stack(
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 0.0),
                          margin: const EdgeInsets.only(top: 50.0),
                          child: CustomPaint(
                            painter: ContainerPainter(),
                            child: Container(
                              padding:
                                  const EdgeInsets.fromLTRB(20, 70, 20, 20),
                              child: Column(
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Color(0xFF19173d),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: TextFormField(
                                        controller: _nameController,
                                        decoration: InputDecoration(
                                          prefixIcon: Padding(
                                            padding: EdgeInsets.only(left: 20),
                                            child: Icon(Icons.person,
                                                color: Colors.white, size: 40),
                                          ),
                                          hintText: 'Enter your name',
                                          hintStyle:
                                              TextStyle(color: Colors.white54),
                                          labelText: 'Name',
                                          labelStyle:
                                              TextStyle(color: Colors.white),
                                          border: InputBorder.none,
                                          contentPadding: EdgeInsets.all(20),
                                          errorStyle: TextStyle(
                                              color: Colors.redAccent),
                                          // Color del texto de error
                                          errorText: _nameError,
                                          suffixIcon: _nameError != null
                                              ? Icon(Icons.error,
                                                  color: Colors.redAccent)
                                              : null,
                                        ),
                                        style: TextStyle(color: Colors.white54),
                                        onChanged: (value) {
                                          setState(() {
                                            _nameError = _validations
                                                .validateName(value);
                                          });
                                        },
                                        validator: (value) =>
                                            _validations.validateName(value),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                  Container(
                                    padding: EdgeInsets.all(0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Color(0xFF19173d),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: TextFormField(
                                        controller: _lastNameController,
                                        decoration: InputDecoration(
                                          prefixIcon: Padding(
                                            padding: EdgeInsets.only(left: 20),
                                            child: Icon(Icons.person,
                                                color: Colors.white, size: 40),
                                          ),
                                          hintText: "Enter your Last Name",
                                          hintStyle:
                                              TextStyle(color: Colors.white54),
                                          labelText: 'Last Name',
                                          labelStyle:
                                              TextStyle(color: Colors.white),
                                          border: InputBorder.none,
                                          contentPadding: EdgeInsets.all(20),
                                          errorStyle: TextStyle(
                                              color: Colors.redAccent),
                                          // Color del texto de error
                                          errorText: _lastNameError,
                                          suffixIcon: _lastNameError != null
                                              ? Icon(Icons.error,
                                                  color: Colors.redAccent)
                                              : null,
                                        ),
                                        style: TextStyle(color: Colors.white54),
                                        onChanged: (value) {
                                          setState(() {
                                            _lastNameError = _validations
                                                .validateName(value);
                                          });
                                        },
                                        validator: (value) =>
                                            _validations.validateName(value),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                  Container(
                                    padding: EdgeInsets.all(0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Color(0xFF19173d),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: TextFormField(
                                        controller: _phoneNumberController,
                                        decoration: InputDecoration(
                                          prefixIcon: Padding(
                                            padding: EdgeInsets.only(left: 20),
                                            child: Icon(Icons.add_ic_call,
                                                color: Colors.white, size: 40),
                                          ),
                                          hintText: "Enter your phoen number",
                                          hintStyle:
                                              TextStyle(color: Colors.white54),
                                          labelText: 'Phone Number',
                                          labelStyle:
                                              TextStyle(color: Colors.white),
                                          border: InputBorder.none,
                                          contentPadding: EdgeInsets.all(20),
                                          errorStyle: TextStyle(
                                              color: Colors.redAccent),
                                          // Color del texto de error
                                          errorText: _phoneNumberError,
                                          suffixIcon: _phoneNumberError != null
                                              ? Icon(Icons.error,
                                                  color: Colors.redAccent)
                                              : null,
                                        ),
                                        style: TextStyle(color: Colors.white54),
                                        onChanged: (value) {
                                          setState(() {
                                            _phoneNumberError = _validations
                                                .validatePhoneNumber(value);
                                          });
                                        },
                                        validator: (value) => _validations
                                            .validatePhoneNumber(value),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                  Container(
                                    padding: EdgeInsets.all(0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Color(0xFF19173d),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: TextFormField(
                                        controller: _emailController,
                                        decoration: InputDecoration(
                                          prefixIcon: Padding(
                                            padding: EdgeInsets.only(left: 20),
                                            child: Icon(Icons.email,
                                                color: Colors.white, size: 40),
                                          ),
                                          hintText: "Enter your email",
                                          hintStyle:
                                              TextStyle(color: Colors.white54),
                                          labelText: 'Email',
                                          labelStyle:
                                              TextStyle(color: Colors.white),
                                          border: InputBorder.none,
                                          contentPadding: EdgeInsets.all(20),
                                          errorStyle: TextStyle(
                                              color: Colors.redAccent),
                                          // Color del texto de error
                                          errorText: _emailError,
                                          suffixIcon: _emailError != null
                                              ? Icon(Icons.error,
                                                  color: Colors.redAccent)
                                              : null,
                                        ),
                                        style: TextStyle(color: Colors.white54),
                                        onChanged: (value) {
                                          setState(() {
                                            _emailError = _validations
                                                .validateEmail(value);
                                          });
                                        },
                                        validator: (value) =>
                                            _validations.validateEmail(value),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Color(0xFF19173d),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    padding: EdgeInsets.all(0),
                                    child: GestureDetector(
                                      onTap: () => _selectDate(context),
                                      child: AbsorbPointer(
                                        child: TextFormField(
                                          controller: _dateController,
                                          decoration: InputDecoration(
                                            prefixIcon: Padding(
                                              padding:
                                                  EdgeInsets.only(left: 20),
                                              child: Icon(Icons.calendar_today,
                                                  color: Colors.white,
                                                  size: 40),
                                            ),
                                            labelText: 'Date Birthday',
                                            labelStyle:
                                                TextStyle(color: Colors.white),
                                            border: InputBorder.none,
                                            contentPadding: EdgeInsets.all(20),
                                          ),
                                          style:
                                              TextStyle(color: Colors.white54),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                  Container(
                                    padding: EdgeInsets.all(0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Color(0xFF19173d),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: TextFormField(
                                        controller: _usernameController,
                                        decoration: InputDecoration(
                                          prefixIcon: Padding(
                                            padding: EdgeInsets.only(left: 20),
                                            child: Icon(Icons.person,
                                                color: Colors.white, size: 40),
                                          ),
                                          hintText: "Enter your username",
                                          hintStyle:
                                              TextStyle(color: Colors.white54),
                                          labelText: 'Username',
                                          labelStyle:
                                              TextStyle(color: Colors.white),
                                          border: InputBorder.none,
                                          contentPadding: EdgeInsets.all(20),
                                          errorStyle: TextStyle(
                                              color: Colors.redAccent),
                                          // Color del texto de error
                                          errorText: _usernameError,
                                          suffixIcon: _usernameError != null
                                              ? Icon(Icons.error,
                                                  color: Colors.redAccent)
                                              : null,
                                        ),
                                        style: TextStyle(color: Colors.white54),
                                        onChanged: (value) {
                                          setState(() {
                                            _usernameError = _validations
                                                .validateUser(value);
                                          });
                                        },
                                        validator: (value) =>
                                            _validations.validateUser(value),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                  Container(
                                    padding: EdgeInsets.all(0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            color: Color(0xFF19173d),
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          child: TextFormField(
                                            controller: _passwordController,
                                            obscureText: _isObscured,
                                            decoration: InputDecoration(
                                              prefixIcon: Padding(
                                                padding:
                                                    EdgeInsets.only(left: 20),
                                                child: Icon(Icons.lock,
                                                    color: Colors.white,
                                                    size: 40),
                                              ),
                                              hintText: "Enter your password",
                                              hintStyle: TextStyle(
                                                  color: Colors.white54),
                                              labelText: 'Password',
                                              labelStyle: TextStyle(
                                                  color: Colors.white),
                                              border: InputBorder.none,
                                              contentPadding:
                                                  EdgeInsets.all(20),
                                              suffixIcon: IconButton(
                                                icon: Icon(
                                                  _isObscured
                                                      ? Icons.visibility_off
                                                      : Icons.visibility,
                                                  color: Colors.white,
                                                ),
                                                onPressed: () {
                                                  setState(() {
                                                    _isObscured = !_isObscured;
                                                  });
                                                },
                                              ),
                                            ),
                                            style: TextStyle(
                                                color: Colors.white54),
                                            onChanged: (value) {
                                              setState(() {
                                                _passwordError = _validations
                                                    .validatePassword(value);
                                              });
                                            },
                                            validator: (value) => _validations
                                                .validatePassword(value),
                                          ),
                                        ),
                                        if (_passwordError != null)
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: 20, top: 5),
                                            child: Text(
                                              _passwordError!,
                                              style: TextStyle(
                                                  color: Colors.redAccent,
                                                  fontSize: 12),
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                  Container(
                                    padding: EdgeInsets.all(0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            color: Color(0xFF19173d),
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          child: TextFormField(
                                            controller:
                                                _confirmPasswordController,
                                            obscureText: _isObscured,
                                            decoration: InputDecoration(
                                              prefixIcon: Padding(
                                                padding:
                                                    EdgeInsets.only(left: 20),
                                                child: Icon(Icons.lock,
                                                    color: Colors.white,
                                                    size: 40),
                                              ),
                                              hintText:
                                                  "Enter your password again",
                                              hintStyle: TextStyle(
                                                  color: Colors.white54),
                                              labelText: 'Password',
                                              labelStyle: TextStyle(
                                                  color: Colors.white),
                                              border: InputBorder.none,
                                              contentPadding:
                                                  EdgeInsets.all(20),
                                              suffixIcon: IconButton(
                                                icon: Icon(
                                                  _isObscured
                                                      ? Icons.visibility_off
                                                      : Icons.visibility,
                                                  color: Colors.white,
                                                ),
                                                onPressed: () {
                                                  setState(() {
                                                    _isObscured = !_isObscured;
                                                  });
                                                },
                                              ),
                                            ),
                                            style: TextStyle(
                                                color: Colors.white54),
                                            onChanged: (value) {
                                              setState(() {
                                                _confirmPasswordError =
                                                    _validations
                                                        .validatePasswordEquals(
                                                            value,
                                                            _passwordController
                                                                .text);
                                              });
                                            },
                                            validator: (value) => _validations
                                                .validatePasswordEquals(value,
                                                    _passwordController.text),
                                          ),
                                        ),
                                        if (_confirmPasswordError != null)
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: 20, top: 5),
                                            child: Text(
                                              _confirmPasswordError!,
                                              style: TextStyle(
                                                  color: Colors.redAccent,
                                                  fontSize: 12),
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                  Container(
                                    child: ElevatedButton(
                                      onPressed: () async {
                                        if (_formKey.currentState!.validate()) {
                                          // Validación asíncrona del nombre de usuario
                                          String? usernameExistsError = await _validations.validateUserExists(_usernameController.text);
                                          if (usernameExistsError != null) {
                                            setState(() {
                                              _usernameError = usernameExistsError;
                                            });
                                            _showAlertDialog("Register invalid", "Username already exists");
                                          } else {
                                            setState(() {
                                              _usernameError = null;
                                            });

                                            // Verificar si se ha seleccionado una imagen
                                            if (_image == null) {
                                              _showAlertDialog("Register invalid", "Please select a profile picture");
                                              return;
                                            }

                                            // Convertir la imagen a base64 antes de enviar la solicitud
                                            await _convertImageToBase64();

                                            // Crear un mapa con los datos del formulario
                                            final userData = {
                                              'firstName': _nameController.text,
                                              'lastName': _lastNameController.text,
                                              'phoneNumber': _phoneNumberController.text,
                                              'email': _emailController.text,
                                              'dateBirthday': _dateController.text,
                                              'username': _usernameController.text,
                                              'password': _passwordController.text,
                                              'userPicture': imageBase64,
                                              'role': "no administrador"
                                            };

                                            // Enviar los datos a la API
                                            ApiService.addUser(userData).then((_) {
                                              getUsers();
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(builder: (context) => LoginPage()),
                                              );
                                            }).catchError((error) {
                                              // Manejo de errores
                                              print(error);
                                              _showAlertDialog("Error", "Failed to register user. Please try again.");
                                            });
                                          }
                                        } else {
                                          _showAlertDialog("Register invalid", "Form incompleted");
                                        }
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Color(0xFF1f4a71),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(20),
                                        ),
                                        padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                                      ),
                                      child: Text('Save', style: TextStyle(color: Colors.white)),
                                    ),
                                  ),

                                ],
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          left: MediaQuery.of(context).size.width / 2 - 60,
                          top: 0,
                          child: GestureDetector(
                            onTap: () async {
                              _showImageSourceActionSheet(context);
                              // Convertir la imagen a base64 después de que el usuario haya seleccionado una imagen
                              await _convertImageToBase64();
                            },
                            child: _image == null
                                ? Icon(
                              Icons.add_a_photo,
                              size: 100,
                              color: Colors.white,
                            )
                                : CircleAvatar(
                              radius: 50,
                              backgroundImage: FileImage(_image!),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        backgroundColor: Color(0xFF19173d),
      ),
    );
  }
}

class ContainerPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Color(0xFF262450)
      ..style = PaintingStyle.fill;

    final path = Path()
      ..moveTo(0, 20)
      ..arcToPoint(Offset(20, 0), radius: Radius.circular(20), clockwise: false)
      ..lineTo(size.width - 20, 0)
      ..arcToPoint(Offset(size.width, 20),
          radius: Radius.circular(20), clockwise: false)
      ..lineTo(size.width, size.height - 20)
      ..arcToPoint(Offset(size.width - 20, size.height),
          radius: Radius.circular(20), clockwise: false)
      ..lineTo(20, size.height)
      ..arcToPoint(Offset(0, size.height - 20),
          radius: Radius.circular(20), clockwise: false)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
