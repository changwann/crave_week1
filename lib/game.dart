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
    currentAnswers =
        List<String>.from(questions[currentQuestion]!); // Copy the list
    correctAnswer = currentAnswers[0]; // Set the correct answer
    currentAnswers.shuffle(); // Shuffle after setting the correct answer
  }

  void checkAnswer(String answer) {
    if (answer == correctAnswer) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('정답입니다!'),
          duration: Duration(milliseconds: 400),
        ),
      );
      // Correct answer, show next question
      setState(() {
        setQuestion();
      });
    } else {
      // Wrong answer, show game over screen or some kind of feedback
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('틀린 답변입니다. 다시 시도해주세요.'),
          duration: Duration(milliseconds: 400),
        ),
      );
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
            Text(
              currentQuestion,
              style: TextStyle(fontSize: 50), // Increase the font size
            ),
            SizedBox(height: 50), // Add some space
            ...currentAnswers.map((answer) {
              return Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 10), // Add some space between buttons
                child: SizedBox(
                  width: 400, // Make buttons have same width
                  height: 60,
                  child: ElevatedButton(
                    child: Text(answer),
                    onPressed: () => checkAnswer(answer),
                  ),
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}
