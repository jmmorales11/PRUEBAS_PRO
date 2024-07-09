import 'package:flutter/material.dart';
import 'package:mascotas/widgets/Background.dart';

class RegistrarMascota extends StatefulWidget {
  const RegistrarMascota({super.key});

  @override
  State<RegistrarMascota> createState() => _RegistrarMascotaState();
}

class _RegistrarMascotaState extends State<RegistrarMascota> {
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
                    height: 40,
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
