import 'package:flutter/material.dart';
import 'package:psychology_app/features/test/presentation/test_page.dart';
import '../domain/test.dart';

class TestCard extends StatelessWidget {
  const TestCard({super.key, required this.test});

  final Test test;

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            colorScheme.primary,
            Colors.transparent
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight
          )

      ),
      child: Card(
        color: colorScheme.surface,
        margin: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(
            vertical: 8.0,
            horizontal: 16.0,
          ),
          title: Text(
            test.name,
            style: const TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 4.0),
              Text(
                'Время выполнения: 8 мин.',
                style: const TextStyle(fontSize: 14.0, color: Colors.grey),
              ),
              const SizedBox(height: 4.0),
              Text(
                'Описание теста...',
                style: const TextStyle(fontSize: 14.0),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => TestDetail(test: test),
              ),
            );
          },
        ),
      ),
    );
  }
}
