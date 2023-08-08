import 'package:flutter/material.dart';
import 'package:flutter_week1/game.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart'; // 'DateFormat'을 사용하기 위해 추가

class ScoreScreen extends StatelessWidget {
  const ScoreScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final scores = Provider.of<ScoreNotifier>(context).scores;
    scores.sort((a, b) => b.item1.compareTo(a.item1));

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              '점수 기록',
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            Expanded(
              child: scores.isEmpty
                  ? Center(child: Text('어서 게임을 플레이해보세요!'))
                  : ListView.builder(
                      itemCount: scores.length,
                      itemBuilder: (context, index) {
                        final time =
                            DateFormat('HH:mm:ss').format(scores[index].item2);
                        return Container(
                          margin: const EdgeInsets.only(top: 10.0),
                          padding: const EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 255, 240, 105),
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          width: MediaQuery.of(context).size.width *
                              0.8, // 80% of screen width
                          child: Center(
                            child: RichText(
                              text: TextSpan(
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                ),
                                children: [
                                  TextSpan(
                                    text: '${index + 1}등 ',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  TextSpan(
                                      text: '${scores[index].item1}점 ($time)'),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
