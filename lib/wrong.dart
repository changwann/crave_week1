// wrong.dart
import 'package:flutter/material.dart';

class WrongScreen extends StatefulWidget {
  final List<Map<String, String>> wrongWords; // 틀린 단어와 올바른 답변을 저장하는 리스트

  WrongScreen({super.key, required this.wrongWords});

  @override
  WrongScreenState createState() => WrongScreenState();
}

class WrongScreenState extends State<WrongScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('틀린 단어 모아보기'),
      ),
      body: ListView.builder(
        itemCount: widget.wrongWords.length,
        itemBuilder: (context, index) {
          final item = widget.wrongWords[index];
          final question = item.keys.first;
          final correctAnswer = item[question];

          return ListTile(
            title: Text("단어: $question"),
            subtitle: Text("정답: $correctAnswer"),
          );
        },
      ),
    );
  }
}
