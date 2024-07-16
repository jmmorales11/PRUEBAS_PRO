import 'dart:io';

import 'package:flutter/material.dart';

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

  File? _image;
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

  void _saveData() {
    // Obtener valores de los campos de texto
    String name = _nameController.text;
    String lastName = _lastNameController.text;
    String phoneNumber = _phoneNumberController.text;
    String email = _emailController.text;
    String username = _usernameController.text;
    String password = _passwordController.text;
    String confirmPassword = _confirmPasswordController.text;
    String dateOfBirth = _dateController.text;

    // Aquí puedes hacer lo que desees con los datos, como guardarlos en variables temporales o realizar validaciones
    // Por ejemplo, puedes imprimirlos en la consola
    print('Name: $name');
    print('Last Name: $lastName');
    print('Phone Number: $phoneNumber');
    print('Email: $email');
    print('Username: $username');
    print('Password: $password');
    print('Confirm Password: $confirmPassword');
    print('Date of Birth: $dateOfBirth');
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
        body: Center(
          child: SingleChildScrollView(
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
                          padding: const EdgeInsets.fromLTRB(20, 70, 20, 20),
                          child: Column(
                            children: [
                              Container(
                                padding: EdgeInsets.all(0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Color(0xFF19173d),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: TextField(
                                    controller: _nameController,
                                    decoration: InputDecoration(
                                      prefixIcon: Padding(
                                        padding: EdgeInsets.only(left: 20),
                                        child: Icon(Icons.person,
                                            color: Colors.white, size: 40),
                                      ),
                                      labelText: 'Name',
                                      labelStyle:
                                          TextStyle(color: Colors.white),
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.all(20),
                                    ),
                                    style: TextStyle(color: Colors.white54),
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
                                  child: TextField(
                                    controller: _lastNameController,
                                    decoration: InputDecoration(
                                      prefixIcon: Padding(
                                        padding: EdgeInsets.only(left: 20),
                                        child: Icon(Icons.person,
                                            color: Colors.white, size: 40),
                                      ),
                                      labelText: 'Last Name',
                                      labelStyle:
                                          TextStyle(color: Colors.white),
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.all(20),
                                    ),
                                    style: TextStyle(color: Colors.white54),
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
                                  child: TextField(
                                    controller: _phoneNumberController,
                                    decoration: InputDecoration(
                                      prefixIcon: Padding(
                                        padding: EdgeInsets.only(left: 20),
                                        child: Icon(Icons.add_ic_call,
                                            color: Colors.white, size: 40),
                                      ),
                                      labelText: 'Phone Number',
                                      labelStyle:
                                          TextStyle(color: Colors.white),
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.all(20),
                                    ),
                                    style: TextStyle(color: Colors.white54),
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
                                  child: TextField(
                                    controller: _emailController,
                                    decoration: InputDecoration(
                                      prefixIcon: Padding(
                                        padding: EdgeInsets.only(left: 20),
                                        child: Icon(Icons.email,
                                            color: Colors.white, size: 40),
                                      ),
                                      labelText: 'Email',
                                      labelStyle:
                                          TextStyle(color: Colors.white),
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.all(20),
                                    ),
                                    style: TextStyle(color: Colors.white54),
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
                                          padding: EdgeInsets.only(left: 20),
                                          child: Icon(Icons.calendar_today,
                                              color: Colors.white, size: 40),
                                        ),
                                        labelText: 'Date Birthday',
                                        labelStyle:
                                            TextStyle(color: Colors.white),
                                        border: InputBorder.none,
                                        contentPadding: EdgeInsets.all(20),
                                      ),
                                      style: TextStyle(color: Colors.white54),
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
                                  child: TextField(
                                    controller: _usernameController,
                                    decoration: InputDecoration(
                                      prefixIcon: Padding(
                                        padding: EdgeInsets.only(left: 20),
                                        child: Icon(Icons.person,
                                            color: Colors.white, size: 40),
                                      ),
                                      labelText: 'Username',
                                      labelStyle:
                                          TextStyle(color: Colors.white),
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.all(20),
                                    ),
                                    style: TextStyle(color: Colors.white54),
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
                                  child: TextField(
                                    controller: _passwordController,
                                    obscureText: _isObscured,
                                    decoration: InputDecoration(
                                      prefixIcon: Padding(
                                        padding: EdgeInsets.only(left: 20),
                                        child: Icon(Icons.lock,
                                            color: Colors.white, size: 40),
                                      ),
                                      labelText: 'Password',
                                      labelStyle:
                                          TextStyle(color: Colors.white),
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.all(20),
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
                                    style: TextStyle(color: Colors.white54),
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
                                  child: TextField(
                                    controller: _confirmPasswordController,
                                    obscureText: _isObscured,
                                    decoration: InputDecoration(
                                      prefixIcon: Padding(
                                        padding: EdgeInsets.only(left: 20),
                                        child: Icon(Icons.lock,
                                            color: Colors.white, size: 40),
                                      ),
                                      labelText: 'Confirm Password',
                                      labelStyle:
                                          TextStyle(color: Colors.white),
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.all(20),
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
                                    style: TextStyle(color: Colors.white54),
                                  ),
                                ),
                              ),
                              SizedBox(height: 20),
                              Container(
                                child: ElevatedButton(
                                  onPressed: _saveData,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Color(0xFF1f4a71),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 50, vertical: 15),
                                  ),
                                  child: Text('Save',
                                      style: TextStyle(color: Colors.white)),
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
                        // onTap: () => _getImage(),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(50),
                          ),
                          padding: EdgeInsets.all(10),
                          child: Icon(
                            Icons.add_a_photo,
                            size: 100,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
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
