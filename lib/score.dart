import 'package:flutter/material.dart';
import 'game.dart';

class ScoreScreen extends StatelessWidget {
  const ScoreScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final scores = ScoreNotifier.of(context)?.scores ?? [];

    return Scaffold(
      appBar: AppBar(
        title: Text('점수 화면'),
      ),
      body: ListView.builder(
        itemCount: scores.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('게임 ${index + 1}의 점수: ${scores[index]}'),
          );
        },
      ),
    );
  }
}
