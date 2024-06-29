import 'package:flutter/material.dart';
import 'package:mascotas/widgets/tab_bar.dart';
import 'package:mascotas/presentation/screens/home_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      debugShowCheckedModeBanner: false,
      home: TabBarCustom(),
    );
  }
}