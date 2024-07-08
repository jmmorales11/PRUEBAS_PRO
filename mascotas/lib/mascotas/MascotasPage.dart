import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: MascotasPage(),
  ));
}

class MascotasPage extends StatefulWidget {
  @override
  _MascotasPageState createState() => _MascotasPageState();
}

class _MascotasPageState extends State<MascotasPage> {
  List<Map<String, String>> cards = [
    {
      'name': 'Nombre 1',
      'description': 'Descripción 1',
      'image': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTwWRH-oXGeRDRQxDcmt1EgAt-FzSg_qAQFBA&s',
      'icon': 'person'
    },
    {
      'name': 'Nombre 2',
      'description': 'Descripción 2',
      'image': 'https://i.pinimg.com/236x/26/24/9a/26249a78777f6e3527d959ed4399dc1e.jpg',
      'icon': 'person'
    }
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Mascotas'),
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
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: cards.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      color: Color(0xFF19173d),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      margin: EdgeInsets.symmetric(vertical: 10),
                      child: ListTile(
                        leading: Icon(Icons.pets, color: Colors.white),
                        title: Text(
                          cards[index]['name']!,
                          style: TextStyle(color: Colors.white),
                        ),
                        subtitle: Text(
                          cards[index]['description']!,
                          style: TextStyle(color: Colors.white70),
                        ),
                        trailing: Image.network(
                          cards[index]['image']!,
                          scale: 1,
                          fit: BoxFit.cover,
                          errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                            return Icon(Icons.error, color: Colors.red);
                          },
                        ),
                      ),
                    );
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.all(16),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => NewCardPage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 22, 61, 96),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                  ),
                  child: Icon(Icons.add, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NewCardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Agregar Nueva Mascota'),
        backgroundColor: Color.fromARGB(255, 22, 61, 96),
      ),
      body: Center(
        child: Text('Agregar Nueva Mascota'),
      ),
    );
  }
}
