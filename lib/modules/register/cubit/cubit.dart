import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/shop_login_model.dart';
import 'package:shop_app/modules/register/cubit/states.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';
import 'package:shop_app/shared/network/remote/end_points.dart';

class ShopCubitRegister extends Cubit<ShopCubitRegisterStates> {
  ShopCubitRegister() : super(ShopCubitRegisterInitialState());

  static ShopCubitRegister get(context) => BlocProvider.of(context);
  late ShopLoginModel loginModel;

  bool isPassword = true;
  IconData suffixIcon = Icons.visibility_outlined;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffixIcon =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(ShopCubitRegisterChangePasswordVisisbility());
  }

  void userRegister({
    required String name,
    required String email,
    required String phone,
    required String password,
  }) {
    emit(ShopCubitRegisterIsLoadingState());
    DioHelper.postData(
      url: register,
      data: {
        'name': name,
        'email': email,
        'phone': phone,
        'password': password,
      },
    ).then((value) {
      loginModel = ShopLoginModel.fromJson(value.data);
      emit(ShopCubitRegisterSuccessState(loginModel));
    }).catchError((error) {
      emit(ShopCubitRegisterErrorState(error.toString()));
      printFullText(error.toString());
    });
  }
}
