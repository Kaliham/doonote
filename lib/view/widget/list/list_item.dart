import 'package:flutter/material.dart';
import 'package:doonote/constants/ui_constants.dart';

class ListItem extends StatelessWidget {
  final Function onTap;
  final Widget child;
  final double height, width;
  ListItem({
    @required this.child,
    this.height = 100,
    this.width = 300,
    @required this.onTap,
  });
  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: kShadowColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: height,
          width: width,
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: child,
        ),
      ),
    );
  }
}
