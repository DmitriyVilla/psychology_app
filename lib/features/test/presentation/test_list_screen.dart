import 'package:flutter/material.dart';
import 'package:psychology_app/features/test/widgets/test_card.dart';
import '../domain/all_test_models.dart';


class TestListScreen extends StatelessWidget {
  final Category category;
  final List<Test> tests;

  const TestListScreen(
      {super.key, required this.category, required this.tests});

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(category.showName),
      ),
      body: tests.isEmpty
          ? const Center(child: Text('Нет доступных тестов для этой категории.'))
          : ListView.builder(
              itemCount: tests.length,
              itemBuilder: (context, index) {
                return TestCard(test: tests[index]);
              },
            ),
    );
  }
}
