import 'package:flutter/material.dart';
import '../domain/all_test_models.dart';

class TestDetail extends StatefulWidget {
  final Test test;

  const TestDetail({super.key, required this.test});

  @override
  State<TestDetail> createState() => _TestDetailState();
}

class _TestDetailState extends State<TestDetail> {
  int _currentQuestionIndex = 0;
  int _totalScore = 0;
  

  void _nextQuestion(int score) {
    setState(() {
      _totalScore += score;
      if (_currentQuestionIndex < widget.test.questions.length - 1) {
        _currentQuestionIndex++;
      } else {
        _showCompletionDialog();
      }
    });
  }

  void _showCompletionDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Тест завершён"),
        content: Text("Ваш общий балл: $_totalScore"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context); // Возврат на предыдущий экран
            },
            child: const Text("Закрыть"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentQuestion = widget.test.questions[_currentQuestionIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.test.name),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Вопрос ${_currentQuestionIndex + 1} из ${widget.test.questions.length}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Text(
              currentQuestion.text,
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            ...currentQuestion.answers.map((answer) {
              return ListTile(
                title: Text(answer.text),
                leading: Radio<int>(
                  value: answer.score,
                  groupValue: null,
                  onChanged: (value) {
                    _nextQuestion(answer.score);
                  },
                ),
              );
            }),
            const SizedBox(height: 20),
            if (_currentQuestionIndex < widget.test.questions.length - 1)
              ElevatedButton(
                onPressed: () => _nextQuestion(0),
                child: const Text("Далее"),
              ),
          ],
        ),
      ),
    );
  }
}
