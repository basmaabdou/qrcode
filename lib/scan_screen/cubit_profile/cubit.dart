import 'package:bloc/bloc.dart' hide FormData;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:scan/scan_screen/cubit_profile/states.dart';
import '../../../../../shared/constants.dart';
import '../../../../../shared/network/remote/dio_helper.dart';
import '../../../../../shared/network/remote/end_point.dart';
import '../../model/exchange_coins_resonse.dart';
import '../../model/ger_coins_response.dart';
import '../../model/profile_response.dart';

class ProfileCubit extends Cubit<ProfileStates> {
  ProfileCubit() : super(ProfileInitial());

  static ProfileCubit get(context) => BlocProvider.of(context);

  ProfileResponse? profileModel;

  void getProfileData() {
    DioHelper.getData(url: PROFILE, token: token).then((value) {
      profileModel = ProfileResponse.fromJson(value.data);
      // print(profileModel!.data!.username);
      emit(SuccessProfileStates());
    }).catchError((error) {
      emit(ErrorProfileStates());
      print(error.toString());
    });
  }




  ExchangeCoins? exchangeCoins;

  void getExchangeCoins({
    required String amount,
    required String id,
  }) {
    emit(LoadingExchangeCoinsStates());
    DioHelper.postData(url: QRCODE, token: token, data: {
      'amount': amount,
      'id':id
    }).then((value) {
      exchangeCoins = ExchangeCoins.fromJson(value.data);
      print(exchangeCoins!.message);
      print(exchangeCoins!.success);
      getProfileData();
      Get.snackbar("Success", "The discount was successful");
      emit(SuccessExchangeCoinsStates());
    }).catchError((error) {
      emit(ErrorExchangeCoinsStates());
      print(error.toString());
      Get.snackbar("Failed", "The number of coins not available");
    });
  }

  GetCoins? getCoins;

  void getCoinsOrder({required String idOrder}) {
    emit(LoadingGetCoinsState());
    DioHelper.postData(
      token: token,
      url: GETCOINS + "/" + idOrder,
    ).then((value) {
      getCoins = GetCoins.fromJson(value.data);
      emit(SuccessGetCoinsState(getCoins!));
      getProfileData();
    }).catchError((error) {
      emit(ErrorGetCoinsState(error.toString()));
    });
  }
}
