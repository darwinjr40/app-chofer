import 'dart:core';
import 'package:flutter/material.dart';
import 'package:micros_app/env.dart';
// ignore: must_be_immutable
class Button extends StatelessWidget {
  final String text;
  final VoidCallback press;
  final Color color, textColor;
  late IconData? icon;

  Button({
    Key? key,
    required this.text,
    required this.press,
    this.icon,
    this.color =  primaryColor,
    this.textColor = primaryLightColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      width: size.width * 0.8,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: color,
          onPrimary: textColor,
        ),
        onPressed: press,
        child: Text(text,
          style: TextStyle(color: textColor),
        ),
      ),
    );
  }
}