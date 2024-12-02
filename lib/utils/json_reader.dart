import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:psychology_app/modell/models.dart';

class JsonReader {
  Future<List<Test>> loadTests(String folderName) async {
    try {
      final manifestString = await rootBundle.loadString('AssetManifest.json');
      final manifestJson = json.decode(manifestString) as Map<String, dynamic>;

      final testFiles = manifestJson.keys
          .where((key) => key.startsWith('assets/$folderName/') && key.endsWith('.json'))
          .toList();

      List<Test> tests = [];
      for (var file in testFiles) {
        final jsonString = await rootBundle.loadString(file);
        final List<dynamic> jsonList = json.decode(jsonString); // Парсим JSON как список
        for (var jsonItem in jsonList) {
          final test = Test.fromJson(jsonItem as Map<String, dynamic>); // Приводим к Map
          tests.add(test);
        }
      }

      return tests;
    } catch (e) {
      print("Ошибка при загрузке тестов: $e");
      return [];
    }
  }
}
