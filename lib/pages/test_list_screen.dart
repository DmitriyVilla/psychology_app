import 'package:flutter/material.dart';

import '../modell/models.dart';

class TestListScreen extends StatelessWidget {
  final Category category;
  final List<Test> tests;

  const TestListScreen({super.key, required this.category, required this.tests});

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
                final test = tests[index];
                return Card(
                  color: colorScheme.primary,
                  margin: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10),
                  elevation: 2.0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  
                  child: ListTile(
                    
                    contentPadding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                    title: Text(
                      test.name,
                      style: TextStyle(fontSize: 20.0),),
                    subtitle: Text('Категория: ${test.category}'),
                    onTap: () {
                      // Переход к подробностям теста
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TestDetail(test: test),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
    );
  }
}