import 'package:flutter/material.dart';
import 'package:doonote/view/widget/theme_switch.dart';

class TopBar extends StatelessWidget {
  final Widget body;
  final Widget topTitle;
  TopBar({@required this.body, @required this.topTitle});
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        body,
        BackButton(),
        Row(
          children: [
            ThemeSwitch(),
          ],
        ),
        topTitle,
      ],
    );
  }
}
