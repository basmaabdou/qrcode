import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:scan/scan_screen/cubit_profile/cubit.dart';
import 'package:scan/scan_screen/home_screen.dart';
import 'package:scan/shared/bloc_observed.dart';
import 'package:scan/shared/constants.dart';
import 'package:scan/shared/network/local/cache_helper.dart';
import 'package:scan/shared/network/remote/dio_helper.dart';

import 'login/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  bool? onBoarding = CacheHelper.getData(
    key: 'onBoarding',
  );
  token = CacheHelper.getData(key: 'token');
  sId = CacheHelper.getData(key: 'id');
  print(token);



  runApp(MyApp(
  ));
}

class MyApp extends StatelessWidget {
  final Widget? startWidget;

  MyApp({this.startWidget});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => ProfileCubit()..getProfileData())
        ],
        child: GetMaterialApp(
          debugShowCheckedModeBanner: false,
          home: LoginScreen(),
        ));
  }
}
