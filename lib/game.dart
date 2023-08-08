import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';
import 'dart:math';
import 'dart:async';
import 'package:provider/provider.dart';
import 'dart:convert';
import 'package:flutter/services.dart';

import 'settings.dart';

Future<Map<String, List<String>>> loadQuestions(String difficulty) async {
  String fileName =
      difficulty == "Easy" ? 'questions_easy.json' : 'questions_hard.json';
  String jsonString = await rootBundle.loadString('assets/$fileName');
  Map<String, dynamic> jsonData = jsonDecode(jsonString);
  return jsonData.map((key, value) => MapEntry(key, List<String>.from(value)));
}

class GameScreen extends StatefulWidget {
  const GameScreen({Key? key}) : super(key: key);

  @override
  GameScreenState createState() => GameScreenState();
}

class GameScreenState extends State<GameScreen> {
  // Sample question and answer data
  late Map<String, List<String>> questions;

  late Timer _timer;
  int _start = 3; // 처음 시작 시간 조절하는 곳
  String currentQuestion = '';
  List<String> currentAnswers = [];
  String correctAnswer = '';
  int correctCount = 0; // Add this to count correct answers

  @override
  void initState() {
    super.initState();
    startTimer();

    final settings = Provider.of<SettingsModel>(context, listen: false);

    loadQuestions(settings.difficulty).then((loadedQuestions) {
      setState(() {
        questions = loadedQuestions;
        setQuestion();
      });
    });
  }

  void startTimer() {
    _timer = Timer.periodic(
      Duration(seconds: 1),
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
            showGameOverScreen();
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  void showGameOverScreen() {
    Provider.of<ScoreNotifier>(context, listen: false).addScore(correctCount);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('게임 종료'),
          content: Text('당신의 최종 점수는 $correctCount 입니다.'),
          actions: <Widget>[
            TextButton(
              child: Text('돌아가기'),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
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
    if (_start == 0) {
      return;
    }

    if (answer == correctAnswer) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('정답입니다!'),
          duration: Duration(milliseconds: 400),
        ),
      );
      // Correct answer, show next question
      setState(() {
        correctCount += 10; // Increase the correct count // Reset the timer
        setQuestion();
      });
    } else {
      setState(() {
        correctCount = max(0, correctCount - 5); // Decrease the correct count
      });
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
  void dispose() {
    _timer.cancel();
    super.dispose();
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
              '현재 점수: $correctCount', // Show the correct count
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            SizedBox(
              height: 10,
              child: LinearProgressIndicator(
                value: _start / 60, // Show the percentage of time left
                valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
              ),
            ),
            SizedBox(height: 20), // Add some space
            Text(
              '남은 시간: $_start', // Show the correct count
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 50),
            Text(
              currentQuestion,
              style: TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.bold), // Increase the font size
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
                    child: Text(answer,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
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

class ScoreNotifier extends ChangeNotifier {
  final List<Tuple2<int, DateTime>> _scores = [];

  List<Tuple2<int, DateTime>> get scores => _scores;

  void addScore(int score) {
    _scores.add(Tuple2(score, DateTime.now()));
    notifyListeners();
  }
}
