import 'package:flutter/material.dart';

class CustomOutlineButton extends StatelessWidget {
  CustomOutlineButton({this.text, this.isActive = false, this.onPressed});

  String text;
  bool isActive;
  VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(color: isActive ? Colors.redAccent : Colors.grey[600]),
      ),
      style: OutlinedButton.styleFrom(
          side: BorderSide(
              color: isActive ? Colors.redAccent : Colors.grey[600], width: 2),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
    );
  }
}
