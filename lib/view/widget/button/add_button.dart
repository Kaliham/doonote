import 'package:flutter/material.dart';

class AddButton extends StatelessWidget {
  final Function onPressed;
  AddButton({@required this.onPressed});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          backgroundColor: Colors.lightGreenAccent[400],
          padding: EdgeInsets.all(15),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.add_circle_outline_sharp,
              color: Colors.white,
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              "Add",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ],
        ),
        onPressed: onPressed,
      ),
    );
  }
}
