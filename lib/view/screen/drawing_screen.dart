import 'package:bidirectional_scroll_view/bidirectional_scroll_view.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:doonote/bloc/cubit/draw_cubit.dart';
import 'package:doonote/constants/route_constants.dart';
import 'package:doonote/view/widget/buttom_bar.dart';
import 'package:doonote/model/colored_path.dart';
import 'package:doonote/view/widget/button/add_button.dart';
import 'package:doonote/view/widget/drawing_area.dart';
import 'package:doonote/service/path_painter.dart';
import 'package:hive/hive.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:doonote/view/widget/hive_box_loader.dart';
import 'package:doonote/view/widget/popup/add_popup.dart';
import 'package:doonote/view/widget/theme_switch.dart';
import 'package:doonote/view/widget/top_bar.dart';

class DrawingScreen extends StatefulWidget {
  final String boxName;
  DrawingScreen({@required this.boxName});
  @override
  _DrawingScreenState createState() => _DrawingScreenState();
}

class _DrawingScreenState extends State<DrawingScreen> {
  var selectedColorIndex = 0;
  String get boxName => widget.boxName;
  @override
  Widget build(BuildContext context) {
    print(boxName);
    return RawKeyboardListener(
      autofocus: true,
      onKey: (value) {
        print(value);
        if (value.logicalKey.keyId == 0x1000700e3) {
          if (!(value is RawKeyUpEvent))
            BlocProvider.of<DrawCubit>(context).set(true);
          else
            BlocProvider.of<DrawCubit>(context).set(false);
        }
      },
      focusNode: FocusNode(),
      child: Scaffold(
        body: content(context),
      ),
    );
  }

  Widget content(BuildContext context) {
    return TopBar(
      body: HiveBoxLoader(
        boxName: boxName,
        builder: (context, snapshot) => Column(
          children: <Widget>[
            Expanded(
              child: BidirectionalScrollViewPlugin(
                velocityFactor: 0.1,
                child: SizedBox(
                  width: 6000,
                  height: 6000,
                  child: Stack(
                    children: <Widget>[
                      WatchBoxBuilder(
                        box: Hive.box(boxName),
                        builder: buildPathsFromBox,
                      ),
                      BlocBuilder<DrawColorCubit, int>(
                        builder: (context, state) {
                          return DrawingArea(
                            selectedColorIndex: state,
                            boxName: boxName,
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            BottomBar(
              boxName: boxName,
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
      topTitle: buildAddButton(context),
    );
  }

  Widget buildAddButton(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      margin: EdgeInsets.only(top: 30),
      child: AddButton(
        onPressed: () {
          AddPopup.show(context, addPopupOnAccept, false);
        },
      ),
    );
  }

  void addPopupOnAccept(String text) {
    Navigator.pop(context);
    Navigator.pop(context);
    Navigator.pushNamed(context, drawRoute, arguments: text);
  }

  Widget buildPathsFromBox(BuildContext context, Box box) {
    var paths = box.values.whereType<ColoredPath>();
    return Stack(
      children: <Widget>[
        for (var path in paths)
          CustomPaint(
            size: Size.infinite,
            painter: PathPainter(path),
          ),
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
    if (Hive.isBoxOpen(boxName)) Hive.box(boxName).close();
  }
}
