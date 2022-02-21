import 'package:shop_app/models/shop_app/register_model.dart';

abstract class RegisterStates {}

class RegisterInitialState extends RegisterStates {}

class RegisterLoadingState extends RegisterStates {}

class RegisterSuccessState extends RegisterStates {
  final RegisterModel regesterModel;
  RegisterSuccessState(this.regesterModel);
}

class RegisterErorrState extends RegisterStates {
  final String erorr;
  RegisterErorrState(this.erorr);
}

class RegisterchangePaasswordVisibilityState extends RegisterStates {}
