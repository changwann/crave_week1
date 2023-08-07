import 'package:flutter/material.dart';
import 'game.dart';

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
        ],
      ),
    );
  }
}
