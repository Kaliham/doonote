import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:doonote/main.dart';

class ThemeSwitch extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Box box = Hive.box(darkModeBox);
    bool darkMode = box.get('darkMode', defaultValue: false);
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Icon(
          darkMode ? Icons.brightness_3 : Icons.brightness_6_rounded,
          color: Colors.amber[300],
        ),
        Switch(
          value: darkMode,
          onChanged: (val) {
            box.put('darkMode', !darkMode);
          },
        ),
      ],
    );
  }
}
