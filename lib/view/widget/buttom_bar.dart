import 'package:flutter/material.dart';
import 'package:doonote/model/colored_path.dart';
import 'package:doonote/view/widget/button/clear_button.dart';
import 'package:doonote/view/widget/button/stop_button.dart';
import 'package:doonote/view/widget/button/undo_button.dart';
import 'package:doonote/view/widget/color_circle.dart';

class BottomBar extends StatelessWidget {
  String boxName;
  BottomBar({@required this.boxName});
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            for (var i = 0; i < ColoredPath.colors.length; i++)
              ColorCirlce(colorIndex: i),
            ClearButton(boxName: boxName),
            UndoButton(boxName: boxName),
            StopButton(),
          ],
        ),
      ],
    );
  }
}
