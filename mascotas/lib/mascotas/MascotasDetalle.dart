import 'package:flutter/material.dart';
import 'Mascota.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MascotasDetalle extends StatefulWidget {
  final Mascota mascota;

  MascotasDetalle({required this.mascota});

  @override
  _MascotasDetalleState createState() => _MascotasDetalleState();
}

class _MascotasDetalleState extends State<MascotasDetalle> {
  List<String> vacunasSeleccionadas = [];
  bool desparasitado = false;

  @override
  void initState() {
    super.initState();
    _loadInformacion();
  }

  Future<void> _loadInformacion() async {
    try {
      // Reemplaza con la URL de tu API para obtener la información de la mascota y las vacunas
      final response = await http.get(Uri.parse('https://back-mascotas.vercel.app/bmpr/vacunas/${widget.mascota.nombreMas}'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        setState(() {
          // Actualizar los datos de vacunas y desparasitante
          vacunasSeleccionadas = List<String>.from(data['vacunas'].map((v) => v['vacuna'] ?? ''));
          desparasitado = data['desparasitado'] ?? false;
        });
      } else {
        throw Exception('Error al cargar la información de la mascota');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> _updateInformacion() async {
    try {
      // Reemplaza con la URL de tu API para actualizar la información de la mascota
      final response = await http.post(
        Uri.parse('https://back-mascotas.vercel.app/bmpr/vacunas/agregar'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'mascota':widget.mascota.nombreMas,
          'vacunas': vacunasSeleccionadas.map((vacuna) => {
            'vacuna': vacuna,
          }).toList(),
          'desparasitado': desparasitado,
        }),
      );

      if (response.statusCode == 200) {
        _loadInformacion(); // Recargar la información actualizada
      } else {
        throw Exception('Error al actualizar la información de la mascota');

      }
    } catch (e) {
      print('Error: $e');
    }
  }

  void _showModal() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Agregar Información'),
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Selecciona las vacunas:'),
                  CheckboxListTile(
                    title: Text('Parvovirus'),
                    value: vacunasSeleccionadas.contains('Parvovirus'),
                    onChanged: (bool? checked) {
                      setState(() {
                        if (checked == true) {
                          vacunasSeleccionadas.add('Parvovirus');
                        } else {
                          vacunasSeleccionadas.remove('Parvovirus');
                        }
                      });
                    },
                  ),
                  CheckboxListTile(
                    title: Text('Moquillo'),
                    value: vacunasSeleccionadas.contains('Moquillo'),
                    onChanged: (bool? checked) {
                      setState(() {
                        if (checked == true) {
                          vacunasSeleccionadas.add('Moquillo');
                        } else {
                          vacunasSeleccionadas.remove('Moquillo');
                        }
                      });
                    },
                  ),
                  CheckboxListTile(
                    title: Text('Rabia'),
                    value: vacunasSeleccionadas.contains('Rabia'),
                    onChanged: (bool? checked) {
                      setState(() {
                        if (checked == true) {
                          vacunasSeleccionadas.add('Rabia');
                        } else {
                          vacunasSeleccionadas.remove('Rabia');
                        }
                      });
                    },
                  ),
                  CheckboxListTile(
                    title: Text('Hepatitis Canina'),
                    value: vacunasSeleccionadas.contains('Hepatitis Canina'),
                    onChanged: (bool? checked) {
                      setState(() {
                        if (checked == true) {
                          vacunasSeleccionadas.add('Hepatitis Canina');
                        } else {
                          vacunasSeleccionadas.remove('Hepatitis Canina');
                        }
                      });
                    },
                  ),
                  SwitchListTile(
                    title: Text('¿Está desparasitada?'),
                    value: desparasitado,
                    onChanged: (bool value) {
                      setState(() {
                        desparasitado = value;
                      });
                    },
                  ),
                ],
              );
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Cerrar el modal
              },
              child: Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () async {
                await _updateInformacion(); // Guardar los cambios
                Navigator.of(context).pop(); // Cerrar el modal
              },
              child: Text('Guardar'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.mascota.nombreMas),
        backgroundColor: Color.fromARGB(255, 22, 61, 96),
      ),
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(16.0),
                                decoration: BoxDecoration(
                                  color: Color(0xFF19173d),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Nombre: ${widget.mascota.nombreMas}', style: TextStyle(fontSize: 20, color: Colors.white)),
                                    SizedBox(height: 10),
                                    Text('Raza: ${widget.mascota.raza}', style: TextStyle(fontSize: 20, color: Colors.white)),
                                    SizedBox(height: 10),
                                    Text('Sexo: ${widget.mascota.sexo}', style: TextStyle(fontSize: 20, color: Colors.white)),
                                    SizedBox(height: 10),
                                    Text('Fecha de nacimiento: ${widget.mascota.fechaNac}', style: TextStyle(fontSize: 20, color: Colors.white)),
                                    SizedBox(height: 10),
                                    Text('Color de pelaje: ${widget.mascota.colorPelaje}', style: TextStyle(fontSize: 20, color: Colors.white)),
                                    SizedBox(height: 10),
                                    Text('Tipo: ${widget.mascota.tipo}', style: TextStyle(fontSize: 20, color: Colors.white)),
                                    SizedBox(height: 10),
                                    Text('Privacidad: ${widget.mascota.privacidad}', style: TextStyle(fontSize: 20, color: Colors.white)),
                                    SizedBox(height: 10),
                                    Text('Descripción: ${widget.mascota.descripcion}', style: TextStyle(fontSize: 20, color: Colors.white)),
                                    SizedBox(height: 10),
                                    Text('Vacunas: ${vacunasSeleccionadas.join(', ')}', style: TextStyle(fontSize: 20, color: Colors.white)),
                                    Text('Desparasitada: ${desparasitado ? 'Sí' : 'No'}', style: TextStyle(fontSize: 20, color: Colors.white)),
                                  ],
                                ),
                              ),
                              SizedBox(height: 20),
                              ElevatedButton(
                                onPressed: _showModal,
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
                                child: Text(
                                  'Agregar más información',
                                  style: TextStyle(
                                      color: const Color.fromARGB(
                                          255, 255, 255, 255),
                                      fontSize: 20),
                                ),
                              ),
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
                        backgroundColor: Colors.transparent,
                        backgroundImage: widget.mascota.imagen != null
                            ? MemoryImage(base64Decode(widget.mascota.imagen!))
                            : AssetImage('assets/default_dog.png') as ImageProvider,
                      ),
                    ),
                  ],
                ),
              ],
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
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
