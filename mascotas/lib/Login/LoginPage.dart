import 'package:flutter/material.dart';
import 'package:mascotas/Register/RegisterPage.dart';
import 'package:mascotas/widgets/tab_bar.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isObscured = true; // Estado para controlar la visibilidad de la contraseña

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: SingleChildScrollView(
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
                                child: TextField(
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(Icons.person, color: Colors.white),
                                    labelText: 'Username',
                                    labelStyle: TextStyle(color: Colors.white),
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
                                child: TextField(
                                  obscureText: _isObscured, // Controla la visibilidad de la contraseña
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
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(right: 10.0),
                                    child: Text(
                                      'Forgot your password?',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 40),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => TabBarCustom()),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xFF19173d),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                                ),
                                child: Text('LOGIN', style: TextStyle(color: Colors.white)),
                              ),
                              SizedBox(height: 20,),
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
                                      color: Colors.white,
                                    ),
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
                                    backgroundColor: Color(0xFF19173d),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                                  ),
                                  child: Text('Register', style: TextStyle(color: Colors.white)),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: MediaQuery.of(context).size.width / 2 - 50,
                      top: 0, // Ajusta este valor para posicionar el avatar
                      child: CircleAvatar(
                        radius: 50.0,
                        backgroundImage: AssetImage('images/Logo.png'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        backgroundColor: Color(0xFF19173d), // Color del fondo
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
      ..arcToPoint(Offset(20, 0), radius: Radius.circular(20), clockwise: true)
      ..lineTo(size.width - 20, 0)
      ..arcToPoint(Offset(size.width, 20), radius: Radius.circular(20), clockwise: true)
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