import 'package:flutter/material.dart';
import 'package:doonote/view/widget/hive_box_loader.dart';
import 'package:doonote/view/widget/top_bar.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TopBar(
      body: HiveBoxLoader(
        boxName: "settings",
        builder: (context, snapshot) {
          return buildContent(context, snapshot);
        },
      ),
      topTitle: Text(
        "Settings",
        style: TextStyle(
          fontFamily: "Open Sans",
          fontSize: 20,
        ),
      ),
    );
  }

  Widget buildContent(BuildContext context, snapshot) {
    return Container();
  }
}
