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
        _selectedScore = null;
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
              Navigator.pop(context);
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
    var brightness = Theme.of(context).brightness;

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
              style: const TextStyle(fontSize: 18),
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
                        brightness == Brightness.light 
                            ? Colors.lightBlueAccent.withOpacity(0.4)
                            : colorScheme.primary.withOpacity(0.2),
                        brightness == Brightness.light
                            ? colorScheme.secondary.withOpacity(0.7)
                            : colorScheme.secondary.withOpacity(0.3),
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
                        style: const TextStyle(fontSize: 18),
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
                              color: brightness == Brightness.light
                                  ? colorScheme.surface.withOpacity(0.9)
                                  : colorScheme.surface.withOpacity(0.4),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: isSelected ? colorScheme.primary : Colors.transparent,
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
                                      color: brightness == Brightness.light
                                          ? colorScheme.onSurface
                                          : colorScheme.onSurface.withOpacity(0.9),
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
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colorScheme.surface,
                      foregroundColor: colorScheme.primary,
                    ),
                    child: const Text("Назад"),
                  ),
                ElevatedButton(
                  onPressed: _selectedScore != null || _currentQuestionIndex == widget.test.questions.length - 1
                      ? _nextQuestion
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colorScheme.surface,
                    foregroundColor: colorScheme.primary,
                  ),
                  child: Text(
                    _currentQuestionIndex < widget.test.questions.length - 1 ? "Далее" : "Завершить",
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
