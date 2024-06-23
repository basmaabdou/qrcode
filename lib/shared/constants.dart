import 'dart:ui';
import 'package:flutter/material.dart';
import 'network/local/cache_helper.dart';




String? token='';

String? sId='';

Color defaultColor=Color(0xff3059A2);

void printFullText(String text) {
  final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}









