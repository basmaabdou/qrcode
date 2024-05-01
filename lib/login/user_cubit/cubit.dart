import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scan/login/user_cubit/states.dart';

import '../../../../shared/network/remote/dio_helper.dart';
import '../../../../shared/network/remote/end_point.dart';
import '../../model/exchange_coins_resonse.dart';
import '../../model/users_model.dart';
import '../../shared/constants.dart';

class UserCubit extends Cubit<UserStates>{
  UserCubit() : super(InitialLogin());

  static UserCubit get(context)=> BlocProvider.of(context);

  UserModel? loginModel;

  void userLogin({
    required String email,
    required String password,
  }) {
    emit(LoginLoadingState());
    DioHelper.postData(
      url: LOGIN,
      data: {
        'email': email,
        'password': password,
      },
    ).then((value) {
      loginModel = UserModel.fromJson(value.data);

      if (loginModel != null) {

        emit(LoginSuccessState(loginModel!));
      } else {
        print('Login model is null');
      }
    }).catchError((error) {
      emit(LoginErrorState(error.toString()));
      print(error.toString());
    });
  }


}