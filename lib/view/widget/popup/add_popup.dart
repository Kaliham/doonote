import 'package:doonote/model/notepad.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:doonote/main.dart';
import 'package:doonote/model/sketch.dart';
import 'package:doonote/view/widget/button/add_button.dart';

class AddPopup {
  static void show(BuildContext context, Function onAccept, bool isNotepad,
      [String sketchBoxId]) {
    Box idBoxObj = isNotepad ? Hive.box(notepadIdsBoxName) : Hive.box(idBox);
    TextEditingController controller = new TextEditingController();
    showDialog(
      context: context,
      builder: (context) => Dialog(
        child: Container(
          padding: EdgeInsets.all(40),
          width: 400,
          height: 400,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              isNotepad
                  ? Center(
                      child: Icon(Icons.collections_bookmark_rounded),
                    )
                  : Center(child: Icon(Icons.color_lens_rounded)),
              Container(
                child: Text(
                  (isNotepad) ? "Add New Notepad" : "Add New Note",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
              Container(
                child: TextField(
                  decoration: InputDecoration(hintText: "Title"),
                  controller: controller,
                  onSubmitted: (text) => onPressed(
                      onAccept, idBoxObj, text, isNotepad, sketchBoxId),
                ),
              ),
              Container(
                child: AddButton(
                  onPressed: () => onPressed(onAccept, idBoxObj,
                      controller.text, isNotepad, sketchBoxId),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static void onPressed(
      Function onAccept, Box idBoxObj, String title, bool isNotepad,
      [String sketchBoxId]) {
    int id = (idBoxObj.get("id", defaultValue: 0) as int) + 1;
    if (isNotepad) {
      addNewNotepad(idBoxObj, title, id);
    } else {
      addNewSketch(idBoxObj, title, id, sketchBoxId);
    }
    onAccept((isNotepad ? "notepad" : "sketch") + id.toString());
  }

  static void addNewSketch(
      Box idBoxObj, String title, int id, String sketchBoxId) {
    idBoxObj.put("id", id);

    Hive.box<Sketch>(sketchBoxId).add(
      Sketch()
        ..id = "sketch" + id.toString()
        ..order = 1
        ..title = title,
    );
  }

  static void addNewNotepad(Box idBoxObj, String title, int id) {
    idBoxObj.put("id", id);
    Hive.box<Notepad>(notepadBoxName).add(
      Notepad()
        ..id = "notepad" + id.toString()
        ..order = 1
        ..title = title,
    );
  }
}
