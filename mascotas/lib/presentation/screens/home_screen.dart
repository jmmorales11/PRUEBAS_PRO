import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late List<StaggeredGridTile> items = [];

  @override
  void initState() {
    super.initState();
    fetchImageUrls(); // Llama al método para obtener las URLs al iniciar la pantalla
  }

  Future<void> fetchImageUrls() async {
    final response = await http.get(Uri.parse('http://localhost:4000/bmpr/img/')); // Reemplaza con la URL de tu API
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      setState(() {
        items = List.generate(data.length, (index) {
          // Genera StaggeredGridTiles basados en los datos recibidos
          int crossAxisCellCount = 2; // Valores entre 1 y 3
          int mainAxisCellCount = Random().nextInt(3) + 1; // Valores entre 1 y 3
          return StaggeredGridTile.count(
            crossAxisCellCount: crossAxisCellCount,
            mainAxisCellCount: mainAxisCellCount,
            child: ImageWidget(index: index, imageUrl: data[index]['imagen']),
          );
        });
      });
    } else {
      throw Exception('Failed to load image urls');
    }
  }

  // Método para actualizar las imágenes
  void actualizarHome() {
    fetchImageUrls(); // Llama al método para actualizar las URLs de las imágenes
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 25, 23, 61),
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
          child: Stack(
            children: [
              //Background(), // No tengo acceso a tu implementación de Background, así que la he comentado temporalmente
              Padding(
                padding: const EdgeInsets.all(15),
                child: ListView(
                  scrollDirection: Axis.vertical,
                  children: [
                    SingleChildScrollView(
                      child: StaggeredGrid.count(
                        crossAxisCount: 4,
                        mainAxisSpacing: 12,
                        crossAxisSpacing: 12,
                        children: items != null ? items : [], // Muestra los items solo si están cargados
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: actualizarHome,
          child: Icon(Icons.refresh),
        ),
      ),
    );
  }
}

class ImageWidget extends StatelessWidget {
  final int index;
  final String imageUrl;

  const ImageWidget({super.key, required this.index, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Image.network(
        imageUrl,
        scale: 1,
        fit: BoxFit.cover,
      ),
    );
  }
}
