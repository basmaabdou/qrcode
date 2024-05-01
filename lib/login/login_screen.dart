import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scan/scan_screen/home_screen.dart';
import 'package:scan/login/user_cubit/cubit.dart';
import 'package:scan/login/user_cubit/states.dart';

import '../../../shared/constants.dart';
import '../../../shared/network/local/cache_helper.dart';
import '../widget/basic.dart';
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
            }

            if (state.loginModel.success == false) {
              messageToast(
                  msg: state.loginModel.message!, state: ToastStates.ERROR);
            }
          }
          if (state is LoginErrorState) {
            messageToast(msg: state.error, state: ToastStates.ERROR);
          }
        },
        builder: (BuildContext context, Object? state) {
          return Form(
            key: formKey,
            child: Scaffold(
              backgroundColor: const Color(0xffFFFFFF),
              appBar: AppBar(
                backgroundColor: const Color(0xffFFFFFF),
                elevation: 0,
              ),
              body: Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                         Text(
                          'Welcom Back',
                          style: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: 32,
                              color: Color(0xff264446)),
                        ),
                        SizedBox(
                          height: 7,
                        ),
                         Text(
                          'Please Enter You Details',
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              color: Color(0xff828A89)),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        defaultTextForm(
                            controller: emailController,
                            type: TextInputType.emailAddress,
                            hintText: 'Email',
                            validate: (value) {
                              if (value!.isEmpty) {
                                return 'email must be not empty';
                              }
                              return null;
                            },
                            prefix: Icons.email_outlined),
                        const SizedBox(
                          height: 25,
                        ),
                        defaultTextForm(
                            controller: passController,
                            type: TextInputType.visiblePassword,
                            hintText: 'Password',
                            validate: (value) {
                              if (value.isEmpty) {
                                return 'the password not allow to be empty';
                              }
                              return null;
                            },
                            prefix: Icons.lock,
                            suffix: isPassword
                                ? Icons.visibility
                                : Icons.visibility_off,
                            isPassword: !isPassword,
                            suffixPressed: () {
                              setState(() {
                                isPassword = !isPassword;
                              });
                            }),
                        const SizedBox(
                          height: 25,
                        ),
                        Center(
                          child: ConditionalBuilder(
                            condition: state is! LoginLoadingState,
                            builder: (context) => Column(
                              children: [
                                DefaultButton(
                                    text: 'Login',
                                    fun: () {
                                      if (formKey.currentState!.validate()) {
                                        UserCubit.get(context).userLogin(
                                            email: emailController.text,
                                            password: passController.text);
                                      }
                                    }),
                              ],
                            ),
                            fallback: (context) =>
                                Center(child: CircularProgressIndicator()),
                          ),
                        ),
                      ],
                    ),
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
