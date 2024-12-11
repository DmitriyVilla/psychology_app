import 'package:flutter/material.dart';
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

class CategoryCard extends StatelessWidget {
  final Category category;

  const CategoryCard({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      color: Colors.deepPurple.shade100,
      child: SizedBox(
        width: 150,
        height: 150,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icon(category.icon, size: 40, color: Colors.deepPurple),
            const SizedBox(height: 8.0),
            Text(
              category.showName,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// class TestListScreen extends StatelessWidget {
//   final Category category;
//   final List<Test> tests;

//   const TestListScreen({super.key, required this.category, required this.tests});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(category.showName),
//       ),
//       body: tests.isEmpty
//           ? const Center(child: Text('Нет доступных тестов для этой категории.'))
//           : ListView.builder(
//               itemCount: tests.length,
//               itemBuilder: (context, index) {
//                 final test = tests[index];
//                 return Card(
//                   child: ListTile(
//                     title: Text(test.name),
//                     subtitle: Text('Категория: ${test.category}'),
//                     onTap: () {
//                       // Переход к подробностям теста
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => TestDetail(test: test),
//                         ),
//                       );
//                     },
//                   ),
//                 );
//               },
//             ),
//     );
//   }
// }

class TestDetail extends StatelessWidget {
  final Test test;

  const TestDetail({super.key, required this.test});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(test.name),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: test.questions.map((question) {
          return Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    question.text,
                    style: const TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  ...question.answers.map((answer) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: Text('- ${answer.text} (баллы: ${answer.score})'),
                    );
                  }),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
