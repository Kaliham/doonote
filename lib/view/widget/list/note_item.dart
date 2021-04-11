import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:doonote/constants/route_constants.dart';
import 'package:doonote/model/adapter/colored_path_adapter.dart';
import 'package:doonote/model/colored_path.dart';
import 'package:doonote/model/sketch.dart';
import 'package:doonote/view/widget/list/list_item.dart';

class NoteItem extends StatelessWidget {
  final Sketch sketch;
  final int index;
  final dynamic boxKey;

  NoteItem({@required this.sketch, @required this.boxKey, this.index});

  @override
  Widget build(BuildContext context) {
    return ListItem(
      onTap: () {
        Navigator.pushNamed(
          context,
          drawRoute,
          arguments: sketch.id,
        );
      },
      child: Row(
        children: [
          Container(),
          Expanded(
            child: Text(
              sketch.title,
              style: TextStyle(
                fontFamily: "Open Sans",
                fontSize: 20,
              ),
            ),
          ),
          Container(
            width: 20,
            child: TextButton(
              child: Icon(
                Icons.remove_circle_outline_rounded,
                color: Colors.red[300],
              ),
              onPressed: deleteOnPressed,
            ),
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
