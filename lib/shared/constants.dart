import 'dart:ui';
import 'package:flutter/material.dart';
import '../login/login_screen.dart';
import '../widget/basic.dart';
import 'network/local/cache_helper.dart';

void signOut(context) {
  CacheHelper.removeDate(key: 'token').then((value) {
    navigateFinish(context, LoginScreen());
  });
}

String? token = '';

String? sId = '';


Color defaultColor = Color(0xffF74F22);
Color textOrangeTheme = Colors.white;

Color defaultGreenColor = Color(0xfff04533b);
Color textGreenTheme = Colors.white;

Color defaultBlueColor = Color(0xff3059A2);
// 0xff01338D
// 0xffF74F22
void printFullText(String text) {
  final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}
