import 'package:flutter/material.dart';

import 'Mascota.dart';

class MascotasDetalle extends StatelessWidget {
  final Mascota mascota;

  MascotasDetalle({required this.mascota});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(mascota.nombreMas),
        backgroundColor: Color.fromARGB(255, 22, 61, 96),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Nombre: ${mascota.nombreMas}', style: TextStyle(fontSize: 20)),
            Text('Raza: ${mascota.raza}', style: TextStyle(fontSize: 20)),
            Text('Sexo: ${mascota.sexo}', style: TextStyle(fontSize: 20)),
            Text('Fecha de nacimiento: ${mascota.fechaNac}', style: TextStyle(fontSize: 20)),
            Text('Color de pelaje: ${mascota.colorPelaje}', style: TextStyle(fontSize: 20)),
            Text('Tipo: ${mascota.tipo}', style: TextStyle(fontSize: 20)),
            Text('Privacidad: ${mascota.privacidad}', style: TextStyle(fontSize: 20)),
            Text('Descripción: ${mascota.descripcion}', style: TextStyle(fontSize: 20)),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AgregarInformacionPage(mascota: mascota),
                  ),
                );
              },
              child: Text('Agregar más información'),
            ),
          ],
        ),
      ),
    );
  }
}

class AgregarInformacionPage extends StatelessWidget {
  final Mascota mascota;

  AgregarInformacionPage({required this.mascota});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Agregar Información'),
        backgroundColor: Color.fromARGB(255, 22, 61, 96),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Agregar información de vacunas y desparasitantes', style: TextStyle(fontSize: 20)),



          ],
        ),
      ),
    );
  }
}
