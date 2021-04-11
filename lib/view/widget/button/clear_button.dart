import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ClearButton extends StatelessWidget {
  String boxName;
  ClearButton({@required this.boxName});
  @override
  Widget build(BuildContext context) {
    return WatchBoxBuilder(
      box: Hive.box(boxName),
      builder: (context, box) {
        return IconButton(
          icon: Icon(Icons.delete),
          onPressed: box.length == 0
              ? null
              : () {
                  box.clear();
                },
        );
      },
    );
  }
}
