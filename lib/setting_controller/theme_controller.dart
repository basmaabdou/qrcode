import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../shared/constants.dart';

class SettingController extends GetxController {
  var boardController1 = PageController();
  RxInt selectedIndex = 0.obs;

  RxInt selectedIndexTheme = 0.obs;
  IconData selectedIcon = Icons.check;

  var boardController2 = PageController(initialPage: 1);
  Color app = defaultBlueColor;
  Color textApp = textOrangeTheme;

  void changeThemeColor(Color color, Color txtColor, int index) {
    app = color;
    selectedIndexTheme.value = index;
    textApp = txtColor;
    update();
  }




}


