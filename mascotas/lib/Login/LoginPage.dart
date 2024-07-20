import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mascotas/RegisterUsers/RegisterPage.dart';
import 'package:mascotas/widgets/tab_bar.dart';
import '../RegisterUsers/ApiServices_Users.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isObscured = true;
  final _formKey = GlobalKey<FormState>();
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  late Map data;
  late List userData = [];

  @override
  void initState() {
    super.initState();
    getUsers();
  }

  Future<void> getUsers() async {
    final List<dynamic> users = await ApiService.getUsers();
    setState(() {
      userData = users;
    });
  }


  bool _validateLogin(String username1, String password1) {
    for (var user in userData) {
      if (user['username'] == username1 && user['password'] == password1) {
        return true;
      }
    }
    return false;
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
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          margin: const EdgeInsets.only(top: 50.0),
                          child: CustomPaint(
                            painter: ContainerPainter(),
                            child: Container(
                              padding: const EdgeInsets.fromLTRB(20, 70, 20, 20),
                              child: Column(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Color(0xFF19173d),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: TextFormField(
                                      controller: _usernameController,
                                      decoration: InputDecoration(
                                        prefixIcon: Icon(Icons.person, color: Colors.white),
                                        labelText: 'Username',
                                        labelStyle: TextStyle(color: Colors.white),
                                        // Color del texto de error
                                        border: InputBorder.none,
                                        contentPadding: EdgeInsets.all(15),
                                      ),
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Color(0xFF19173d),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: TextFormField(
                                      controller: _passwordController,
                                      obscureText: _isObscured,
                                      decoration: InputDecoration(
                                        prefixIcon: Icon(Icons.lock, color: Colors.white),
                                        suffixIcon: IconButton(
                                          icon: Icon(
                                            _isObscured ? Icons.visibility : Icons.visibility_off,
                                            color: Colors.white,
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              _isObscured = !_isObscured;
                                            });
                                          },
                                        ),
                                        labelText: 'Password',
                                        labelStyle: TextStyle(color: Colors.white),
                                        border: InputBorder.none,
                                        contentPadding: EdgeInsets.all(15),
                                      ),
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                  SizedBox(height: 10),

                                  SizedBox(height: 40),
                                  ElevatedButton(
                                    onPressed: () {

                                      if(_usernameController.text.isNotEmpty && _passwordController.text.isNotEmpty){
                                        if(_validateLogin(_usernameController.text, _passwordController.text)){
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(builder: (context) => TabBarCustom()),
                                          );
                                        }else{
                                          _showAlertDialog("Login invalid","Username or password incorrect");
                                        }
                                      }else{
                                        _showAlertDialog("Login invalid", "Texfield empty");
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Color(0xFF1f4a71),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                                    ),
                                    child: Text('LOGIN', style: TextStyle(color: Colors.white)),
                                  ),
                                  SizedBox(height: 20),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Container(
                                          height: 2,
                                          color: Colors.white,
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                      Icon(Icons.keyboard_arrow_down, color: Colors.white),
                                      SizedBox(width: 10),
                                      Expanded(
                                        child: Container(
                                            height: 2,
                                            color: Colors.white),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 40),
                                  Text(
                                    "You don't have an account yet?",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  SizedBox(height: 40),
                                  Container(
                                    child: ElevatedButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) => RegisterPage()),
                                        );
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Color(0xFF1f4a71),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(20),
                                        ),
                                        padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                                      ),
                                      child: Text('RegisterUsers', style: TextStyle(color: Colors.white)),
                                    ),
                                  ),
                                  SizedBox(height: 60),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          left: MediaQuery.of(context).size.width / 2 - 50,
                          top: 0,
                          child: CircleAvatar(
                            radius: 50.0,
                            backgroundColor: Colors.transparent, // Color de fondo opcional
                            child: Icon(
                              Icons.account_circle,
                              size: 100, // Ajusta el tamaño del icono según el radio del CircleAvatar
                              color: Colors.white, // Ajusta el color del icono si es necesario
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
      ),
    );
  }
}

class ContainerPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Color.fromARGB(61, 0, 0, 0)
      ..style = PaintingStyle.fill;

    final path = Path()
      ..moveTo(0, 20)
      ..arcToPoint(Offset(20, 0), radius: Radius.circular(20), clockwise: false)
      ..lineTo(size.width - 20, 0)
      ..arcToPoint(Offset(size.width, 20), radius: Radius.circular(20), clockwise: false)
      ..lineTo(size.width, size.height - 20)
      ..arcToPoint(Offset(size.width - 20, size.height), radius: Radius.circular(20), clockwise: true)
      ..lineTo(20, size.height)
      ..arcToPoint(Offset(0, size.height - 20), radius: Radius.circular(20), clockwise: true)
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
