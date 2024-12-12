import 'package:flutter/material.dart';
import 'package:psychology_app/features/test/widgets/category_card.dart';
import 'package:psychology_app/features/test/data/category_loader.dart';
import '../domain/all_test_models.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final CategoryLoader _categoryLoader = CategoryLoader();
  List<Category> categories = [];
  double maxWidth = 0;

  @override
  void initState() {
    super.initState();
    _loadCategories();
  }

  Future<void> _loadCategories() async {
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
          : LayoutBuilder(
              builder: (context, constraints) {
                // Определяем максимальную ширину карточки
                final availableWidth = constraints.maxWidth;
                maxWidth = availableWidth > 400 ? 400 : availableWidth / 2 - 24;

                return SingleChildScrollView(
                  child: Center(
                    child: Wrap(
                      // spacing: 16.0, // Горизонтальное расстояние
                      // runSpacing: 16.0, // Вертикальное расстояние
                      children: categories.map((category) {
                        return CategoryCard(
                          category: category,
                          width: maxWidth, // Передаём максимальную ширину
                        );
                      }).toList(),
                    ),
                  ),
                );
              },
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
