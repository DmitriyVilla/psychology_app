import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:psychology_app/features/test/domain/category.dart';

class CategoryLoader {
  Future<List<Category>> loadCategories() async {
    final String jsonString = await rootBundle.loadString('assets/categories.json');
    final List<dynamic> jsonData = json.decode(jsonString);
    return jsonData.map((item) => Category.fromJson(item)).toList();
  }
}
