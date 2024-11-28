import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Beispiel-Daten für Kategorien
  final List<Category> categories = [
    Category(name: 'Самооценка', icon: Icons.self_improvement),
    Category(name: 'Стресс', icon: Icons.spa),
    Category(name: 'Отношения', icon: Icons.favorite),
    Category(name: 'Карьера', icon: Icons.work),
    // Füge weitere Kategorien hinzu
  ];

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
  appBar: AppBar(
    title: const Text('Психологические тесты'),
    centerTitle: true,
  ),
  body: LayoutBuilder(
    builder: (context, constraints) {
      // Anzahl der Spalten basierend auf der Bildschirmbreite anpassen
      int crossAxisCount = constraints.maxWidth > 600 ? 3 : 2; // 3 Spalten bei größeren Bildschirmen
      return GridView.builder(
        padding: const EdgeInsets.all(16.0),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount, // Anzahl der Spalten
          crossAxisSpacing: 16.0,
          mainAxisSpacing: 16.0,
        ),
        itemCount: categories.length, // Anzahl der Kategorien
        itemBuilder: (context, index) {
          final category = categories[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TestListScreen(category: category),
                ),
              );
            },
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
              color: Colors.deepPurple.shade100, // Hintergrundfarbe der Karten
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(category.icon, size: 40, color: Colors.deepPurple),
                  const SizedBox(height: 8.0),
                  Text(
                    category.name,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple, // Textfarbe der Kategorien
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    },
  ),
);

  }
}

// Datenmodell für Kategorien
class Category {
  final String name;
  final IconData icon;

  Category({required this.name, required this.icon});
}

// Beispiel-Testlisten-Bildschirm
class TestListScreen extends StatelessWidget {
  final Category category;

  const TestListScreen({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(category.name),
      ),
      body: Center(
        child: Text('Список тестов для категории: ${category.name}'),
      ),
    );
  }
}
