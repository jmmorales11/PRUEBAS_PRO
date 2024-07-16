import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mascotas/widgets/Background.dart';
import 'package:http/http.dart' as http;

class RegistrarMascota extends StatefulWidget {
  const RegistrarMascota({super.key});

  @override
  State<RegistrarMascota> createState() => _RegistrarMascotaState();
}

class _RegistrarMascotaState extends State<RegistrarMascota> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nombre_mas = TextEditingController();
  final TextEditingController _raza = TextEditingController();
  final TextEditingController _sexo = TextEditingController();
  final TextEditingController _fecha_nac = TextEditingController();
  final TextEditingController _color = TextEditingController();
  final TextEditingController _tipo = TextEditingController();
  final TextEditingController _privacidad = TextEditingController();
  final TextEditingController _descripcion = TextEditingController();
  bool insertar = false;
  Future<void> postMascota(
      String nombre,
      String raza,
      String sexo,
      String fecha_nac,
      String color,
      String tipo,
      String privacidad,
      String descripcion,
      String user) async {
    try {
      final response = await http.post(
        Uri.parse('https://back-mascotas.vercel.app/bmpr/mascotas/crear'),
        body: json.encode({
          'nombre_mas': nombre,
          'raza': raza,
          'sexo': sexo,
          'fecha_nac': fecha_nac,
          'color_pelaje': color,
          'tipo': tipo,
          'privacidad': privacidad,
          'descripcion': descripcion,
          'user': user
        }),
        headers: {
          'Content-Type': 'application/json',
        },
      );
      print(response.statusCode);
      if (response.statusCode == 200) {
        setState(() {
          insertar = true;
        });
        _nombre_mas.clear();
        _raza.clear();
        _sexo.clear();
        _fecha_nac.clear();
        _color.clear();
        _tipo.clear();
        _privacidad.clear();
        _descripcion.clear();
        // Actualizar la lista de usuarios después de la inserción
      }
    } catch (error) {
      print('Error : $error');
      // Manejar errores según sea necesario
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Stack(
          children: [
            Background(),
            SingleChildScrollView(
              child: Container(
                child: Column(children: [
                  Center(
                    child: Container(
                        child: Stack(
                      alignment: Alignment.center,
                      children: [
                        SizedBox(height: 100),
                        Container(
                          margin: EdgeInsets.only(top: 20),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(
                                color: Color.fromARGB(240, 22, 61, 96),
                                width: 2),
                            color: Color.fromARGB(255, 101, 170, 23),
                          ),
                          width: 300,
                          height: 250,
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 70),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(
                                color: Color.fromARGB(240, 22, 61, 96),
                                width: 2),
                            color: Color.fromARGB(255, 168, 66, 66),
                          ),
                          width: 350,
                          height: 250,
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 130),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(
                                  color: Color.fromARGB(240, 22, 61, 96),
                                  width: 2),
                              color: Color.fromARGB(255, 114, 38, 145)),
                          width: 400,
                          height: 250,
                        ),
                      ],
                    )),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Icon(
                    Icons.camera_alt,
                    color: Colors.white,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    child: Center(
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(
                                  color: Color.fromARGB(240, 22, 61, 96),
                                  width: 2),
                              color: const Color.fromARGB(61, 0, 0, 0),
                            ),
                            width: 400,
                            child: TextField(
                              controller: _nombre_mas,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                labelText: 'Nombre Mascota',
                                labelStyle: TextStyle(color: Colors.white),
                                prefixIcon: Icon(
                                  Icons.person,
                                  color: Colors.white,
                                ),
                              ),
                              style: TextStyle(color: Colors.white),
                              keyboardType: TextInputType.name,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(
                                  color: Color.fromARGB(240, 22, 61, 96),
                                  width: 2),
                              color: const Color.fromARGB(61, 0, 0, 0),
                            ),
                            width: 400,
                            child: TextField(
                              controller: _raza,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                labelText: 'Raza',
                                labelStyle: TextStyle(color: Colors.white),
                                prefixIcon: Icon(
                                  Icons.person,
                                  color: Colors.white,
                                ),
                              ),
                              style: TextStyle(color: Colors.white),
                              keyboardType: TextInputType.name,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(
                                  color: Color.fromARGB(240, 22, 61, 96),
                                  width: 2),
                              color: const Color.fromARGB(61, 0, 0, 0),
                            ),
                            width: 400,
                            child: TextField(
                              controller: _sexo,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                labelText: 'Sexo',
                                labelStyle: TextStyle(color: Colors.white),
                                prefixIcon: Icon(
                                  Icons.person,
                                  color: Colors.white,
                                ),
                              ),
                              style: TextStyle(color: Colors.white),
                              keyboardType: TextInputType.name,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(
                                  color: Color.fromARGB(240, 22, 61, 96),
                                  width: 2),
                              color: const Color.fromARGB(61, 0, 0, 0),
                            ),
                            width: 400,
                            child: TextField(
                              controller: _fecha_nac,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                labelText: 'Fecha de nacimiento',
                                labelStyle: TextStyle(color: Colors.white),
                                prefixIcon: Icon(
                                  Icons.person,
                                  color: Colors.white,
                                ),
                              ),
                              style: TextStyle(color: Colors.white),
                              keyboardType: TextInputType.name,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(
                                  color: Color.fromARGB(240, 22, 61, 96),
                                  width: 2),
                              color: const Color.fromARGB(61, 0, 0, 0),
                            ),
                            width: 400,
                            child: TextField(
                              controller: _color,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                labelText: 'Color del pelaje',
                                labelStyle: TextStyle(color: Colors.white),
                                prefixIcon: Icon(
                                  Icons.person,
                                  color: Colors.white,
                                ),
                              ),
                              style: TextStyle(color: Colors.white),
                              keyboardType: TextInputType.name,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(
                                  color: Color.fromARGB(240, 22, 61, 96),
                                  width: 2),
                              color: const Color.fromARGB(61, 0, 0, 0),
                            ),
                            width: 400,
                            child: TextField(
                              controller: _tipo,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                labelText: 'Tipo de mascota',
                                labelStyle: TextStyle(color: Colors.white),
                                prefixIcon: Icon(
                                  Icons.person,
                                  color: Colors.white,
                                ),
                              ),
                              style: TextStyle(color: Colors.white),
                              keyboardType: TextInputType.name,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(
                                  color: Color.fromARGB(240, 22, 61, 96),
                                  width: 2),
                              color: const Color.fromARGB(61, 0, 0, 0),
                            ),
                            width: 400,
                            child: TextField(
                              controller: _privacidad,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                labelText: 'Privacidad',
                                labelStyle: TextStyle(color: Colors.white),
                                prefixIcon: Icon(
                                  Icons.person,
                                  color: Colors.white,
                                ),
                              ),
                              style: TextStyle(color: Colors.white),
                              keyboardType: TextInputType.name,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(
                                  color: Color.fromARGB(240, 22, 61, 96),
                                  width: 2),
                              color: const Color.fromARGB(61, 0, 0, 0),
                            ),
                            width: 400,
                            child: TextField(
                              controller: _descripcion,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                labelText: 'Descripcion',
                                labelStyle: TextStyle(color: Colors.white),
                                prefixIcon: Icon(
                                  Icons.person,
                                  color: Colors.white,
                                ),
                              ),
                              style: TextStyle(color: Colors.white),
                              keyboardType: TextInputType.name,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 55, vertical: 10),

                              backgroundColor: Color.fromARGB(
                                  60, 23, 68, 165), // Color de fondo

                              shadowColor: const Color.fromARGB(
                                  61, 0, 0, 0), // Color de la sombra
                              elevation: 5, // Tamaño de la sombra
                              side: BorderSide(
                                color: Color.fromARGB(
                                    239, 40, 125, 199), // Color del borde
                                width: 2, // Ancho del borde
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    17), // Bordes redondeados
                              ),
                            ),
                            onPressed: () {
                              //  if (_formKey.currentState?.validate() ?? false) {
                              // Aquí puedes manejar el envío de datos
                              print(_nombre_mas);
                              postMascota(
                                  _nombre_mas.text,
                                  _raza.text,
                                  _sexo.text,
                                  _fecha_nac.text,
                                  _color.text,
                                  _tipo.text,
                                  _privacidad.text,
                                  _descripcion.text,
                                  "Marley");
                              //   }
                            },
                            child: Text(
                              'Insertar',
                              style: TextStyle(
                                  color:
                                      const Color.fromARGB(255, 255, 255, 255),
                                  fontSize: 20),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                  )
                ]),
              ),
            )
          ],
        ),
      ),
    );
  }
}
