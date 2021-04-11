import 'package:doonote/model/notepad.dart';
import 'package:doonote/view/widget/list/notepad_item.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:doonote/main.dart';
import 'package:doonote/model/sketch.dart';
import 'package:doonote/view/widget/button/add_button.dart';
import 'package:doonote/view/widget/list/list_item.dart';
import 'package:doonote/view/widget/list/note_item.dart';
import 'package:doonote/view/widget/popup/add_popup.dart';
import 'package:doonote/view/widget/theme_switch.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _header(),
          _buildAdd(context),
          Expanded(
            child: FutureBuilder(
              future: Hive.openBox<Notepad>(notepadBoxName),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.error != null) {
                    return Scaffold(
                      body: Center(
                        child: Text('Something went wrong :/'),
                      ),
                    );
                  } else {
                    return _buildContent(context);
                  }
                } else {
                  return Scaffold(
                    body: Center(
                      child: Text('Loading...'),
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _header() {
    Box box = Hive.box(darkModeBox);
    bool darkMode = box.get('darkMode', defaultValue: false);
    return Stack(
      children: [
        Container(
          height: 100,
          alignment: Alignment.center,
          child: Text(
            "DooNote",
            style: TextStyle(
              fontSize: 32,
            ),
          ),
        ),
        ThemeSwitch(),
      ],
    );
  }

  Widget _buildAdd(BuildContext context) {
    return Container(
      height: 100,
      width: double.infinity,
      child: Container(
        width: 100,
        height: 30,
        alignment: Alignment.center,
        child: Center(
          child: AddButton(
            onPressed: () {
              AddPopup.show(context, (string) {
                Navigator.pop(context);
                print("done");
              }, true);
            },
          ),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    Box<Notepad> box = Hive.box<Notepad>(notepadBoxName);
    return Container(
      child: ValueListenableBuilder(
        valueListenable: box.listenable(),
        builder: (context, Box<Notepad> value, child) {
          print(value.values);
          List<Notepad> notepads = value.values.toList().reversed.toList();
          List<dynamic> keys = value.keys.toList().reversed.toList();
          return Container(
            width: 600,
            child: ListView.builder(
              itemCount: notepads.length,
              itemBuilder: (context, index) {
                return NotepadItem(
                  notepad: notepads[index],
                  index: index,
                  boxKey: keys[index],
                );
              },
            ),
          );
        },
      ),
    );
  }
}
