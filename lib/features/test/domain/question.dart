import 'package:psychology_app/features/test/domain/answer.dart';


class Question {
  final String text; // Der Text der Frage
  final List<Answer> answers; // Liste von möglichen Antworten

  Question({required this.text, required this.answers});

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      text: json['question'],
      answers: (json['answers'] as List).map((answer) => Answer.fromJson(answer)).toList(),
    );
  }
}
