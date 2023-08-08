import 'package:flutter/material.dart';
import 'package:flutter_week1/wrong.dart';
import 'package:flutter_week1/game.dart';

class TimerScreen extends StatelessWidget {
  const TimerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset('assets/clock.png', width: 300, height: 300),
          SizedBox(height: 50),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              minimumSize: Size(200, 60), // Set the minimum size of the button
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => GameScreen()),
              );
            },
            child: Text('게임 시작', style: TextStyle(fontSize: 20)),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 255, 107, 97),
              minimumSize: Size(200, 60), // Set the minimum size of the button
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        WrongScreen(wrongWords: globalWrongWords)),
              );
            },
            child: Text('틀린 단어 모아보기', style: TextStyle(fontSize: 20)),
          ),
        ],
      ),
    );
  }
}
