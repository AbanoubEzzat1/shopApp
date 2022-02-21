import 'package:shop_app/models/shop_app/login_model.dart';

abstract class LoginStates {}

class LoginInitialState extends LoginStates {}

class LoginLoadingState extends LoginStates {}

class LoginSuccessState extends LoginStates {
  final ShopLoginModel loginModel;
  LoginSuccessState(this.loginModel);
}

class LoginErorrState extends LoginStates {
  final String erorr;
  LoginErorrState(this.erorr);
}

class LoginchangePaasswordVisibilityState extends LoginStates {}
