import 'package:psychology_app/features/test/domain/question.dart';

class Test {

  final String name;
  final String category;
  

  final List<Question> questions;

  Test({required this.name, required this.category, required this.questions});  

  factory Test.fromJson(Map<String, dynamic> json) {
    return Test(
      name: json['name'],
      category: json['category'],
      questions: (json['questions'] as List)
          .map((question) => Question.fromJson(question))
          .toList(),
    );
  }
}