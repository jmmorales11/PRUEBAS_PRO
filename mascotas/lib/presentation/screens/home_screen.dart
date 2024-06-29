import 'package:flutter/material.dart';
import 'package:mascotas/widgets/Background.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Método para actualizar las imágenes
  void actualizarHome() {}

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Background(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: ListView(
                scrollDirection: Axis.vertical,
                children: [
                  const Row(
                    children: [
                      Text(
                        "Home Screen",
                        style: TextStyle(color: Colors.white, fontSize: 24),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
