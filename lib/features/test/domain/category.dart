//import 'package:flutter/material.dart';


class Category {
  final String showName;
  final String folderName; // Название категории
  //final IconData icon; // Иконка категории

  // Конструктор
  Category({required this.showName, required this.folderName});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      showName: json['showName'],
      folderName: json['folderName'],

    );
  }
}

