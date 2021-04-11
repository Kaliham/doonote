import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:doonote/bloc/cubit/draw_cubit.dart';
import 'package:doonote/model/colored_path.dart';
import 'package:doonote/service/path_painter.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class DrawingArea extends StatefulWidget {
  final int selectedColorIndex;

  final String boxName;
  DrawingArea({this.selectedColorIndex, this.boxName});

  @override
  _DrawingAreaState createState() => _DrawingAreaState();
}

class _DrawingAreaState extends State<DrawingArea> {
  var path = ColoredPath(0);
  String get boxName => widget.boxName;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DrawCubit, bool>(
      builder: (context, state) {
        print(state);
        return AbsorbPointer(
          absorbing: state,
          child: GestureDetector(
            onPanUpdate: (details) {
              addPoint(details.globalPosition);
            },
            onPanStart: (details) {
              path = ColoredPath(widget.selectedColorIndex);
              addPoint(details.globalPosition);
            },
            onPanEnd: (details) {
              Hive.box(boxName).add(path);
              setState(() {
                path = ColoredPath(0);
              });
            },
            child: CustomPaint(
              size: Size.infinite,
              painter: PathPainter(path),
            ),
          ),
        );
      },
    );
  }

  void addPoint(Offset point) {
    var renderBox = context.findRenderObject() as RenderBox;
    setState(() {
      path.addPoint(renderBox.globalToLocal(point));
    });
  }
}
