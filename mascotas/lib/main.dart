import 'package:flutter/material.dart';
import 'package:mascotas/Login/LoginPage.dart';
import 'package:mascotas/Register/RegisterPage.dart';
import 'package:mascotas/mascotas/MascotasPage.dart';
import 'package:mascotas/mascotas/registrar_mascota.dart';
import 'package:mascotas/widgets/tab_bar.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: RegistrarMascota(),
    );
  }
}
