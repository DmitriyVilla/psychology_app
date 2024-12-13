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
  int? _selectedScore;

  void _nextQuestion() {
    setState(() {
      if (_selectedScore != null) {
        _totalScore += _selectedScore!;
      }
      if (_currentQuestionIndex < widget.test.questions.length - 1) {
        _currentQuestionIndex++;
        _selectedScore = null;
      } else {
        _showCompletionDialog();
      }
    });
  }

  void _previousQuestion() {
    setState(() {
      if (_currentQuestionIndex > 0) {
        _currentQuestionIndex--;
        _selectedScore = null; // Reset selected answer for current question
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
    var colorScheme = Theme.of(context).colorScheme;

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
              style: TextStyle(fontSize: 18, color: colorScheme.onSecondary.withOpacity(0.5)),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    gradient: LinearGradient(
                      colors: [
                        Colors.lightBlueAccent.withOpacity(0.4),
                        colorScheme.secondary.withOpacity(0.7),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text( 
                        currentQuestion.text, 
                        style: TextStyle(fontSize: 18, color: colorScheme.onSecondary),
                      ),
                      const SizedBox(height: 20),
                      ...currentQuestion.answers.map((answer) {
                        final isSelected = _selectedScore == answer.score;
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedScore = answer.score;
                            });
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 8),
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: colorScheme.onPrimary, //isSelected ? const Color(0xFF00E0EB).withOpacity(0.2) : Colors.white.withOpacity(0.8),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: isSelected ? Color(0xFF00E0EB) : Colors.transparent,
                                width: 3,
                              ),
                            ),
                            child: Row(
                              children: [
                                Radio<int>(
                                  value: answer.score,
                                  groupValue: _selectedScore,
                                  onChanged: (value) {
                                    setState(() {
                                      _selectedScore = value;
                                    });
                                  },
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    answer.text,
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: colorScheme.onSecondary// isSelected ? Colors.white : Colors.black,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (_currentQuestionIndex > 0)
                  ElevatedButton(
                    onPressed: _previousQuestion,
                    child: Text(
                      "Назад",
                      style: TextStyle(
                        color: colorScheme.onSecondary,

                      )
                    ),
                  ),
                ElevatedButton(
                  onPressed: _selectedScore != null || _currentQuestionIndex == widget.test.questions.length - 1
                      ? _nextQuestion
                      : null,
                  child: Text(
                    _currentQuestionIndex < widget.test.questions.length - 1 ? "Далее" : "Завершить",
                    style: TextStyle(
                      color: colorScheme.onSecondary,

                    )                    
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
