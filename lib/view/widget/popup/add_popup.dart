import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:doonote/main.dart';
import 'package:doonote/model/sketch.dart';
import 'package:doonote/view/widget/button/add_button.dart';

class AddPopup {
  static void show(BuildContext context, Function onAccept) {
    Box idBoxObj = Hive.box(idBox);
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
              Container(
                child: Text(
                  "Add New Note",
                  style: TextStyle(
                    fontFamily: "Open Sans",
                    fontSize: 20,
                  ),
                ),
              ),
              Container(
                child: TextField(
                  decoration: InputDecoration(hintText: "Title"),
                  controller: controller,
                  onSubmitted: (text) => onPressed(onAccept, idBoxObj, text),
                ),
              ),
              Container(
                child: AddButton(
                  onPressed: () =>
                      onPressed(onAccept, idBoxObj, controller.text),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static void onPressed(Function onAccept, Box idBoxObj, String title) {
    int id = (idBoxObj.get("id", defaultValue: 0) as int) + 1;
    addNewSketch(idBoxObj, title, id);
    onAccept("sketch" + id.toString());
  }

  static void addNewSketch(Box idBoxObj, String title, int id) {
    idBoxObj.put("id", id);
    Hive.box<Sketch>(sketchBoxName).add(
      Sketch()
        ..id = "sketch" + id.toString()
        ..order = 1
        ..title = title,
    );
  }
}
