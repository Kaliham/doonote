import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ColoredPath {
  static const colors = [
    Color(0xAA596275),
    Color(0xFFdff9fb),
    Color(0xFFc44569),
    Color(0xFF55efc4),
    Color(0xFF74b9ff),
    Color(0xFFe66767),
    Color(0xFFa29bfe),
    Color(0xFF63cdda),
    Color(0xFFf78fb3),
    Color(0xFFf6e58d),
    Color(0xFFbadc58),
    Color(0xFF686de0),
    Color(0xFFff7979)
  ];

  Color blueGrey() => Colors.blueGrey[300];

  static List<Paint> _paints;

  Paint get paint {
    if (_paints == null) {
      _paints = [];
      for (var color in colors) {
        _paints.add(
          Paint()
            ..strokeCap = StrokeCap.round
            ..isAntiAlias = true
            ..color = color
            ..strokeWidth = 3
            ..style = PaintingStyle.stroke,
        );
      }
    }
    return _paints[colorIndex];
  }

  final int colorIndex;

  final path = Path();

  List<Offset> points = [];

  ColoredPath(this.colorIndex);

  void addPoint(Offset point) {
    if (points.isEmpty) {
      path.moveTo(point.dx, point.dy);
    } else {
      path.lineTo(point.dx, point.dy);
    }
    points.add(point);
  }
}
