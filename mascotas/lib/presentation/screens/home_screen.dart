import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late List<StaggeredGridTile> items;

  @override
  void initState() {
    super.initState();
    generateGridItems();
  }

  void generateGridItems() {
    items = List.generate(5, (index) {
      int crossAxisCellCount = 2; // Valores entre 1 y 3
      int mainAxisCellCount = Random().nextInt(3) + 1; // Valores entre 1 y 3
      return StaggeredGridTile.count(
        crossAxisCellCount: crossAxisCellCount,
        mainAxisCellCount: mainAxisCellCount,
        child: ImageWidget(index: index),
      );
    });
  }

  // Método para actualizar las imágenes
  void actualizarHome() {
    setState(() {
      generateGridItems();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            // Background(), // No tengo acceso a tu implementación de Background, así que la he comentado temporalmente
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
                      children: items,
                    ),
                  ),
                ],
              ),
            ),
          ],
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

  const ImageWidget({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    int photoId = Random().nextInt(30) + 55;
    int sizeMultiplier = photoId % 7;

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Image.network(
        "https://picsum.photos/id/$photoId/300/${200 * sizeMultiplier}",
        scale: 1,
        fit: BoxFit.cover,
      ),
    );
  }
}
