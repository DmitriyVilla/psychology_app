import 'package:flutter/material.dart';
import 'package:psychology_app/utils/json_reader.dart';
import 'package:psychology_app/modell/models.dart'; // Импортируем модели

class SelfEsteem extends StatefulWidget {
  const SelfEsteem({super.key});

  @override
  _SelfEsteemState createState() => _SelfEsteemState();
}

class _SelfEsteemState extends State<SelfEsteem> {
  late Future<List<Test>> _tests;

  @override
  void initState() {
    super.initState();
    // Загрузка тестов из папки self_esteem
    _tests = JsonReader().loadTests('self_esteem');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Самооценка'),
        centerTitle: true,
      ),
      body: FutureBuilder<List<Test>>(
        future: _tests,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Ошибка: ${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Нет доступных тестов.'));
          }

          final tests = snapshot.data!;

          return ListView.builder(
            itemCount: tests.length,
            itemBuilder: (context, index) {
              final test = tests[index];
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: InkWell(
                  onTap: () {
                    // Переход на экран с тестом
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TestDetail(test: test),
                      ),
                    );
                  },
                  child: ListTile(
                    title: Text(test.name, style: const TextStyle(fontSize: 18)),
                    subtitle: Text('Категория: ${test.category}'),
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



