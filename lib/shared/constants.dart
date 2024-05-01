import 'dart:ui';
import 'package:flutter/material.dart';
import 'network/local/cache_helper.dart';




String? token='';

String? sId='';

Color defaultColor=Color(0xffF74F22);
Color textOrangeTheme=Colors.white;

Color defaultGreenColor=Color(0xfff04533b);
Color textGreenTheme=Colors.white;

void printFullText(String text) {
  final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}









