import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/shop_app/register_model.dart';
import 'package:shop_app/shared/cubit/registerstates.dart';
import 'package:shop_app/shared/network/end_points.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitialState());
  static RegisterCubit get(context) => BlocProvider.of(context);
  bool isbassword = true;
  IconData suffex = Icons.visibility_off_outlined;
  void changePaasswordVisibility() {
    isbassword = !isbassword;
    suffex =
        isbassword ? Icons.visibility_off_outlined : Icons.visibility_outlined;
    emit(RegisterchangePaasswordVisibilityState());
  }

  RegisterModel? registerModel;
  void userRegister({
    required String email,
    required String password,
    required String name,
    required String phone,
    String? image,
  }) {
    emit(RegisterLoadingState());
    DioHelper.postData(
      url: REGISTER,
      data: {
        'email': email,
        'password': password,
        'name': name,
        'phone': phone,
        'image': image,
      },
    ).then((value) {
      print(value.data);
      registerModel = RegisterModel.fromJson(value.data);
      emit(RegisterSuccessState(registerModel!));
    }).catchError((erorr) {
      print(erorr.toString());
      emit(RegisterErorrState(erorr));
    });
  }
}
