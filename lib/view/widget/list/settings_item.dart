import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:doonote/model/sketch.dart';
import 'package:doonote/view/widget/list/list_item.dart';

class SettingsItem extends StatelessWidget {
  final Sketch sketch;
  final int index;
  final dynamic boxKey;

  TextStyle get style => TextStyle(
        fontFamily: "Open Sans",
        fontSize: 20,
      );

  SettingsItem({@required this.sketch, @required this.boxKey, this.index});

  @override
  Widget build(BuildContext context) {
    return ListItem(
      onTap: () {},
      child: Row(
        children: [
          Container(),
          Expanded(
            child: Text(
              sketch.title,
              style: style,
            ),
          ),
          TextButton(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Text(
                "edit",
                style: style,
              ),
            ),
            onPressed: deleteOnPressed,
          ),
        ],
      ),
    );
  }

  void deleteOnPressed() {
    Hive.deleteBoxFromDisk(sketch.id);
    Hive.box<Sketch>(sketchBoxName).delete(boxKey);
  }
}
