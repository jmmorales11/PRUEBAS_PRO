import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mascotas/widgets/Background.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io' as io;
import 'package:image/image.dart' as img;
import 'dart:typed_data';

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
  final TextEditingController _image1 = TextEditingController();
  final TextEditingController _image2 = TextEditingController();
  final TextEditingController _image3 = TextEditingController();
  String? _imageBase64;
  int contador = 0;
  bool insertar = false;
  io.File? _image; // Variable para almacenar la imagen seleccionada
  List<io.File?> images = List.filled(3, null);
  List<String?> imagePaths = List.filled(3, null);
  List<String?> imageBase = List.filled(3, null);
  String? imagePath; // Ruta de la imagen seleccionada

  final ImagePicker _picker = ImagePicker();

  Future<void> postImage(String image, String nombre, String privacidad) async {
    try {
      final response = await http.post(
        Uri.parse('https://back-mascotas.vercel.app/bmpr/img/crear'),
        body: json.encode(
            {'mascota': nombre, 'privacidad': privacidad, 'imagen': image}),
        headers: {'Content-Type': 'application/json'},
      );
      print("---------------------------------------------");
      print("Response body: ${response.body}");
      if (response.statusCode == 200) {
        setState(() {
          insertar = true;
        });
      }
    } catch (e) {
      print("Error posting image: $e");
    }
  }

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

  //__________________________________________________________________________________________________________________-

  // Método para abrir la cámara y seleccionar una imagen
  Future<void> _openCamera(int i) async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        images[contador] =
            io.File(pickedFile.path); // Guardar la imagen seleccionada
        imagePaths[contador] = pickedFile.path;
        contador++; // Guardar la ruta de la imagen
      });

      _saveImagePath(pickedFile.path);
      // Guarda la ruta en SharedPreferences
    }
  }

  // Método para abrir la galería y seleccionar una imagen
  Future<void> _openGallery(int i) async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        print(
            "-----------------------------------------------------------------------------------------------------------------------------\N----------------------------${contador}----------------------------------------------------");

        images[contador] =
            io.File(pickedFile.path); // Guardar la imagen seleccionada
        imagePaths[contador] = pickedFile.path;
        contador++; // Guardar la ruta de la imagen
      });

      _saveImagePath(pickedFile.path);
      // Guarda la ruta en SharedPreferences
    }
  }

  // Método para guardar la ruta de la imagen en SharedPreferences
  Future<void> _saveImagePath(String path) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('imagePath', path);
  }

  // Método para cargar la imagen guardada desde SharedPreferences
  Future<void> _loadImage(int i) async {
    final prefs = await SharedPreferences.getInstance();
    final path = prefs.getString('imagePath');
    // Validación si existe una imagen guardada

    if (path != null) {
      setState(() {
        images[i] = io.File(path); // Guardar la imagen seleccionada
        imagePaths[i] = path; // Guardar la ruta de la imagen
        //imagePath = path; // Asigna la ruta de la imagen
        //_image = io.File(path); // Carga la imagen en _image (solo para web)
      });
    }
  }

  //--------------------------------------------------------------------------------------------------------------------
  //TRANSFORMAR LA IMAGEN A BASE64
  Future<void> _convertImageToBase64() async {
    for (int i = 0; i < images.length; i++) {
      if (images[i] != null) {
        List<int> imageBytes = await images[i]!.readAsBytes();
        Uint8List uint8ImageBytes = Uint8List.fromList(imageBytes);
        img.Image? image = img.decodeImage(uint8ImageBytes);

        if (image != null) {
          img.Image resizedImage = img.copyResize(image, width: 600);
          List<int> compressedImageBytes =
              img.encodeJpg(resizedImage, quality: 50);
          String imageBase64 = base64Encode(compressedImageBytes);
          imageBase[i] = imageBase64;

          print(
              "Imagen $i en Base64: ${imageBase[i]!.substring(0, 100)}..."); // Imprime solo los primeros 100 caracteres
          await Future.delayed(Duration(seconds: 2));
        }
      }
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
                        if (images[0] != null)
                          Container(
                            margin: EdgeInsets.only(top: 20),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(
                                  color: Color.fromARGB(240, 22, 61, 96),
                                  width: 2),
                              color: Color.fromARGB(255, 101, 170, 23),
                              image: DecorationImage(
                                image: FileImage(images[0]!),
                                fit: BoxFit.cover,
                              ),
                            ),
                            width: 300,
                            height: 250,
                          ),
                        if (images[1] != null)
                          Container(
                            margin: EdgeInsets.only(top: 70),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(
                                  color: Color.fromARGB(240, 22, 61, 96),
                                  width: 2),
                              color: Color.fromARGB(255, 168, 66, 66),
                              image: DecorationImage(
                                image: FileImage(images[1]!),
                                fit: BoxFit.cover,
                              ),
                            ),
                            width: 350,
                            height: 250,
                          ),
                        if (images[2] != null)
                          Container(
                              width: 400,
                              height: 250,
                              margin: EdgeInsets.only(top: 130),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                border: Border.all(
                                    color: Color.fromARGB(240, 22, 61, 96),
                                    width: 2),
                                color: Color.fromARGB(255, 114, 38, 145),
                                image: DecorationImage(
                                  image: FileImage(images[2]!),
                                  fit: BoxFit.cover,
                                ),
                              )),
                      ],
                    )),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(height: 20),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            _openCamera(contador -
                                3); // Abre la cámara para el contenedor 0
                          },
                          child: Icon(
                            Icons.camera_alt,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(width: 30),
                        GestureDetector(
                          onTap: () {
                            _openGallery(contador -
                                3); // Abre la galería para el contenedor 2
                          },
                          child: Icon(
                            Icons.image,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
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
                            onPressed: () async {
                              // Call _convertImageToBase64 and wait for it to complete
                              await _convertImageToBase64();
                              // Now you can safely use imageBase[0]
                              if (imageBase[1] != null) {
                                await postImage(imageBase[1]!, _nombre_mas.text,
                                    _privacidad.text);
                              }

                              // postMascota(
                              //     _nombre_mas.text,
                              //     _raza.text,
                              //     _sexo.text,
                              //     _fecha_nac.text,
                              //     _color.text,
                              //     _tipo.text,
                              //     _privacidad.text,
                              //     _descripcion.text,
                              //     "Marley");

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
