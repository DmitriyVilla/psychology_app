import 'package:flutter/material.dart';
import 'package:psychology_app/features/test/data/json_reader.dart';
import 'package:psychology_app/features/test/domain/all_test_models.dart';
import 'package:psychology_app/features/test/presentation/test_list_screen.dart';
import '../domain/category.dart';

class CategoryCard extends StatefulWidget {
  final Category category;
  final double width; // Добавляем ширину как параметр

  const CategoryCard({
    super.key,
    required this.category,
    required this.width, // Ширина карточки передаётся извне
  });

  @override
  State<CategoryCard> createState() => _CategoryCardState();
}

class _CategoryCardState extends State<CategoryCard> {
  final JsonReader _jsonReader = JsonReader();

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;
    return SizedBox(
      width: widget.width, // Устанавливаем фиксированную ширину карточки
      child: Card(
        elevation: 4.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: InkWell(
          borderRadius: BorderRadius.circular(16.0),
          onTap: () async {
            // Загружаем тесты для категории
            final tests = await _jsonReader.loadTests(widget.category.folderName);
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        TestListScreen(category: widget.category, tests: tests)));
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16.0),
            child: Stack(
              children: [
                // Фоновое изображение
                Positioned.fill(
                  child: Image.asset(
                    'assets/images/meditative.webp',
                    fit: BoxFit.cover,
                  ),
                ),
                // Затемнение для текста
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          colorScheme.primary.withOpacity(0.6), //const Color.fromARGB(255, 144, 132, 206)
                          Colors.transparent,
                        ],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      ),
                    ),
                  ),
                ),
                // Текст на карточке
                Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        widget.category.showName,
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: colorScheme.onPrimary,
                        ),
                      ),
                      const SizedBox(height: 4.0),
                      Text(
                        'Erlernen Sie effektive Techniken, um Stress zu reduzieren und innere Ruhe zu finden...', //category.description,
                        style: TextStyle(
                          fontSize: 14.0,
                          color: colorScheme.onPrimary,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
