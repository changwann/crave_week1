import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';

class SettingsModel extends ChangeNotifier {
  bool _isMusicOn = true;
  String _difficulty = "Easy";

  bool get isMusicOn => _isMusicOn;
  String get difficulty => _difficulty;

  set isMusicOn(bool value) {
    _isMusicOn = value;
    notifyListeners(); // 값이 변경될 때마다 알림을 보냅니다.
  }

  set difficulty(String value) {
    _difficulty = value;
    notifyListeners();
  }
}

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  SettingsScreenState createState() => SettingsScreenState();
}

class SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    final settings = Provider.of<SettingsModel>(context);

    return ListView(
      padding: EdgeInsets.all(16.0),
      children: [
        ListTile(
          title: Text('배경음악'),
          trailing: Switch(
            value: settings.isMusicOn,
            onChanged: (value) {
              settings.isMusicOn = value;
              // 여기서 배경 음악 ON/OFF 처리를 추가할 수 있습니다.
            },
          ),
        ),
        ListTile(
          title: Text('영단어 난이도'),
          trailing: DropdownButton<String>(
            value: settings.difficulty,
            items: <String>['Easy', 'Hard'].map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (value) {
              settings.difficulty = value!;
              // 여기서 난이도 변경 처리를 추가할 수 있습니다.
            },
          ),
        ),
      ],
    );
  }
}
