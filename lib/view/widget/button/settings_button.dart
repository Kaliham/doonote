import 'package:flutter/material.dart';
import 'package:doonote/constants/route_constants.dart';

class SettingsButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.settings),
      onPressed: () {
        Navigator.pushNamed(context, settingsRoute);
      },
    );
  }
}
