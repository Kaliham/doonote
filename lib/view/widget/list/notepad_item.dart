import 'package:doonote/model/notepad.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:doonote/constants/route_constants.dart';
import 'package:doonote/model/sketch.dart';
import 'package:doonote/view/widget/list/list_item.dart';

class NotepadItem extends StatelessWidget {
  final Notepad notepad;
  final int index;
  final dynamic boxKey;

  NotepadItem({@required this.notepad, @required this.boxKey, this.index});

  @override
  Widget build(BuildContext context) {
    return ListItem(
      onTap: () {
        Navigator.pushNamed(
          context,
          notepadRoute,
          arguments: notepad,
        );
      },
      child: Row(
        children: [
          Container(
            width: 60,
            child: Icon(Icons.collections_bookmark_rounded),
          ),
          Expanded(
            child: Text(
              notepad.title,
              style: TextStyle(
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
              onPressed: () => deleteOnPressed(context),
            ),
          ),
        ],
      ),
    );
  }

  void deleteOnPressed(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        titlePadding: EdgeInsets.all(20),
        contentPadding: EdgeInsets.all(20),
        title: Text(
            "are you sure, you want to delete " + notepad.title + " notepad?"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("decline"),
          ),
          TextButton(
            onPressed: () {
              Hive.deleteBoxFromDisk(notepad.id);
              Hive.box<Notepad>(notepadBoxName).delete(boxKey);
              Navigator.pop(context);
            },
            child: Text("accept"),
          ),
        ],
      ),
    );
  }
}
