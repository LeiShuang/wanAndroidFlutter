import 'package:flutter/material.dart';

class ThemeUtils{
  static  const Color defaultColor =  Colors.green;

  // 可选的主题色
  static const List<Color> supportColors = [
    defaultColor,
    Colors.purple,
    Colors.orange,
    Colors.deepPurpleAccent,
    Colors.redAccent,
    Colors.blue,
    Colors.amber,
    Colors.green,
    Colors.lime,
    Colors.indigo,
    Colors.cyan,
    Colors.teal
  ];

  // 当前的主题色
  static Color currentColorTheme = defaultColor;
}