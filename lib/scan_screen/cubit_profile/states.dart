

import '../../model/exchange_coins_resonse.dart';
import '../../model/ger_coins_response.dart';

abstract class ProfileStates{}

class ProfileInitial extends ProfileStates{}

class LoadingProfileStates extends ProfileStates{}

class SuccessProfileStates extends ProfileStates{}

class ErrorProfileStates extends ProfileStates{}

class LoadingOrderStates extends ProfileStates{}

class SuccessOrderStates extends ProfileStates{}

class ErrorOrderStates extends ProfileStates{}




class LoadingExchangeCoinsStates extends ProfileStates{}

class SuccessExchangeCoinsStates extends ProfileStates{
  final ExchangeCoins exchangeCoins;

  SuccessExchangeCoinsStates(this.exchangeCoins);
}

class ErrorExchangeCoinsStates extends ProfileStates{
}


class LoadingGetCoinsState extends ProfileStates {}

class SuccessGetCoinsState extends ProfileStates {
  final GetCoins getCoins;
  SuccessGetCoinsState(this.getCoins);

}

class ErrorGetCoinsState extends ProfileStates {
  final String error;
  ErrorGetCoinsState(this.error);
}
