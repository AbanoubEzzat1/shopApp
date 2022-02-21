import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/shop_app/login_model.dart';
import 'package:shop_app/shared/cubit/login_states.dart';
import 'package:shop_app/shared/network/end_points.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialState());
  static LoginCubit get(context) => BlocProvider.of(context);
  late ShopLoginModel loginModel;
  bool isbassword = true;
  IconData suffex = Icons.visibility_off_outlined;
  void changePaasswordVisibility() {
    isbassword = !isbassword;
    suffex =
        isbassword ? Icons.visibility_off_outlined : Icons.visibility_outlined;
    emit(LoginchangePaasswordVisibilityState());
  }

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
      print(value.data);
      loginModel = ShopLoginModel.fromJson(value.data);
      emit(LoginSuccessState(loginModel));
    }).catchError((erorr) {
      print(erorr.toString());
      emit(LoginErorrState(erorr));
    });
  }
}
