import 'package:flutter/material.dart';
import 'dart:math';

class GameScreen extends StatefulWidget {
  const GameScreen({Key? key}) : super(key: key);

  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  // Sample question and answer data
  final Map<String, List<String>> questions = {
    'Apple': ['사과', '바나나', '딸기', '포도'],
    'Banana': ['바나나', '사과', '멜론', '참외'],
    'Grape': ['포도', '바나나', '딸기', '사과'],
  };

  String currentQuestion = '';
  List<String> currentAnswers = [];
  String correctAnswer = '';

  @override
  void initState() {
    super.initState();
    setQuestion();
  }

  void setQuestion() {
    currentQuestion =
        questions.keys.elementAt(Random().nextInt(questions.length));
    correctAnswer = questions[currentQuestion]![0];
    currentAnswers = questions[currentQuestion]!;
    currentAnswers.shuffle();
  }

  void checkAnswer(String answer) {
    if (answer == correctAnswer) {
      // Correct answer, show next question
      setState(() {
        setQuestion();
      });
    } else {
      // Wrong answer, show game over screen or some kind of feedback
      // For simplicity, here we just shuffle the answers again
      setState(() {
        currentAnswers.shuffle();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('게임 화면'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('단어: $currentQuestion'),
            ...currentAnswers.map((answer) {
              return ElevatedButton(
                child: Text(answer),
                onPressed: () => checkAnswer(answer),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}
