import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {


  //metodo para actualizar las imagenes
  void actualizarHome(){

  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: ListView(
            scrollDirection: Axis.vertical,
            children: [
              Row(
                children: [
                  Text("Home Screen")
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}