import 'package:flutter/material.dart';
import 'package:psychology_app/features/test/widgets/category_card.dart';
import 'package:psychology_app/features/test/presentation/test_list_screen.dart';
import 'package:psychology_app/features/test/data/json_reader.dart'; // Импортируем класс для чтения JSON
import 'package:psychology_app/features/test/data/category_loader.dart';

import '../domain/all_test_models.dart'; // Импортируем класс для чтения JSON

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
  
}

class HomePageState extends State<HomePage> {
  
  final CategoryLoader _categoryLoader = CategoryLoader();
  final JsonReader _jsonReader = JsonReader();
  List<Category> categories = [];

  @override  
  void initState() {
    super.initState();
    _loadCategories();
  }

  Future<void> _loadCategories  () async {
    final loadedCategories = await _categoryLoader.loadCategories();
    setState(() {
      categories = loadedCategories;
    });
  }

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Психологические тесты'),
        centerTitle: true,
      ),
      body: categories.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Wrap(
                    spacing: 16.0, // Расстояние между картами по горизонтали
                    runSpacing: 16.0, // Расстояние между картами по вертикали
                    children: categories.map((category) {
                      return GestureDetector(
                        onTap: () async {
                          // Загружаем тесты для категории
                          final tests = await _jsonReader.loadTests(category.folderName);
                          // Переходим на экран с тестами
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => TestListScreen(
                                category: category,
                                tests: tests,
                              ),
                            ),
                          );
                        },
                        child: CategoryCard(category: category),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
    );
  }
}

// class CategoryCard extends StatelessWidget {
//   final Category category;

//   const CategoryCard({super.key, required this.category});

//   @override
//   Widget build(BuildContext context) {
//     var colorScheme = Theme.of(context).colorScheme;

//     return Card(
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(16.0),
//       ),
//       color: colorScheme.primary,
//       child: SizedBox(
//         width: 150,
//         height: 150,
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             // Icon(category.icon, size: 40, color: Colors.deepPurple),
//             const SizedBox(height: 8.0),
//             Text(
//               category.showName,
//               textAlign: TextAlign.center,
//               style: TextStyle(
//                 fontSize: 16.0,
//                 fontWeight: FontWeight.bold,
//                 color: colorScheme.onPrimary,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
