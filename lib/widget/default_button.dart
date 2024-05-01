import 'package:flutter/material.dart';
import 'package:scan/shared/constants.dart';
import 'package:sizer/sizer.dart';


class DefaultButton extends StatelessWidget {
  final String text;
  final fun;

   DefaultButton({super.key, required this.text, required this.fun});
  //SettingController controller=Get.find();
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 315,
      height:50,
      decoration: BoxDecoration(
          color: defaultColor,
          borderRadius: BorderRadius.circular(20)
      ),
      child: MaterialButton(
        onPressed: fun,
        child: Text(
          text,
          style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w400
          ),
        ),
      ),
    );
  }
}
