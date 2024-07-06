import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:scan/login/user_cubit/cubit.dart';
import 'package:scan/login/user_cubit/states.dart';
import 'package:scan/widget/basic.dart';
import '../../../shared/constants.dart';
import '../../../shared/network/local/cache_helper.dart';
import '../scan_screen/home_screen.dart';
import '../setting_controller/theme_controller.dart';
import '../widget/default_button.dart';
import '../widget/default_text_form_field..dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var emailController = TextEditingController();
  var passController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  bool isPassword = false;

  SettingController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => UserCubit(),
      child: BlocConsumer<UserCubit, UserStates>(
        listener: (BuildContext context, state) {
          if (state is LoginSuccessState) {
            if (state.loginModel.success == true) {
              navigateFinish(context, HomeScreen());
              CacheHelper.saveData(key: 'token', value: state.loginModel.token)
                  .then((value) {
                token = state.loginModel.token;
              });
            } else {
              messageToast(msg: 'Check your internet', state: ToastStates.ERROR);
            }
          } else if (state is LoginErrorState) {
            messageToast(msg: 'Username or Password is wrong', state: ToastStates.ERROR);
          }
        },
        builder: (BuildContext context, Object? state) {
          return Form(
            key: formKey,
            child: Scaffold(
              backgroundColor: const Color(0xffFFFFFF),
              body: SingleChildScrollView(
                child: Directionality(
                  textDirection: controller.selectedIndex == 0
                      ? TextDirection.ltr
                      : TextDirection.rtl,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image(
                        image: AssetImage(
                          controller.app == defaultBlueColor
                              ? 'assets/images/blueLogo.jpg'
                              : controller.app == defaultGreenColor
                              ? 'assets/images/greenLogoo.png'
                              : 'assets/images/orangeLogo.jpeg',
                        ),
                        width: double.infinity,
                        height: 30.h,
                        fit: controller.app == defaultBlueColor ? BoxFit.fill : BoxFit.cover,
                      ),
                      if (controller.app == defaultBlueColor) SizedBox(height: 5.h),
                      Padding(
                        padding: EdgeInsetsDirectional.symmetric(horizontal: 2.h),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Login to your Account',
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 3.h,
                                  color: controller.app,
                                ),
                              ),
                              SizedBox(height: 7),
                              Text(
                                'Scan the user\'s QR code and control their coins',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 15,
                                  color: Color(0xff828A89),
                                ),
                              ),
                              SizedBox(height: 5.h),
                              defaultTextForm(
                                controller: emailController,
                                type: TextInputType.emailAddress,
                                hintText: 'Email Address',
                                validate: (value) {
                                  if (value!.isEmpty) {
                                    return 'Email must not be empty';
                                  }
                                  return null;
                                },
                                prefix: Icons.email_outlined,
                              ),
                              const SizedBox(height: 25),
                              defaultTextForm(
                                controller: passController,
                                type: TextInputType.visiblePassword,
                                hintText: "Password",
                                validate: (value) {
                                  if (value.isEmpty) {
                                    return 'Password must not be empty';
                                  }
                                  return null;
                                },
                                prefix: Icons.lock,
                                suffix: isPassword ? Icons.visibility : Icons.visibility_off,
                                isPassword: !isPassword,
                                suffixPressed: () {
                                  setState(() {
                                    isPassword = !isPassword;
                                  });
                                },
                              ),
                              const SizedBox(height: 20),
                              Center(
                                child: ConditionalBuilder(
                                  condition: state is! LoginLoadingState,
                                  builder: (context) => Container(
                                    width: 315,
                                    child: DefaultButton(
                                      text: 'Login',
                                      fun: () {
                                        if (formKey.currentState!.validate()) {
                                          UserCubit.get(context).userLogin(
                                            email: emailController.text,
                                            password: passController.text,
                                          );
                                        }
                                      },
                                    ),
                                  ),
                                  fallback: (context) => Center(
                                    child: CircularProgressIndicator(
                                      color: controller.app,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
