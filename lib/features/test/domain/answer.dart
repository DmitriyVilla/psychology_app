class Answer {
  final String text; // Der Text der Antwort
  final int score; // Die Bewertung der Antwort

  Answer({required this.text, required this.score});

  factory Answer.fromJson(Map<String, dynamic> json) {
    return Answer(
      text: json['text'],
      score: json['score'],
    );
  }
}
