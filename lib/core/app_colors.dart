import 'package:flutter/material.dart';

class AppColors {
  // Light Theme Colors
  static const lightPrimary = Color(0xFF87CEEB); // для акцентов
  static const lightSecondary = Color(0xFF7FB2F0); // для второстепенных акцентов
  static const lightBackground = Color.fromARGB(255, 33, 37, 41); // для фона
  static const lightSurface = Color(0xFFFFFFFF); // для карточек и поверхностей

  // Dark Theme Colors
  static const darkPrimary = Color.fromRGBO(121, 131, 216, 1); // для акцентов
  static const darkSecondary = Color.fromRGBO(127, 178, 240, 1); // для второстепенных акцентов
  static const darkBackground = Color.fromARGB(255, 0, 47, 96); // для ночной темы
  static const darkSurface = Color.fromARGB(255, 30, 30, 30); // для поверхностей

  // Общие цвета для обеих тем
  static const error = Color(0xFFFF6B6B); // Красный для ошибок
  static const textPrimaryLight = Color(0xFF333333); // для светлой темы
  static const textSecondaryLight = Color(0xFF888888); //  для светлой темы
  static const textPrimaryDark = Color(0xFFFFFFFF); // Белый текст для тёмной темы
  static const textSecondaryDark = Color(0xFFB0B0B0); //для тёмной темы
}
