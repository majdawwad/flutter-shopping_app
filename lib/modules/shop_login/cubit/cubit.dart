import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/shop_login_model.dart';
import 'package:shop_app/modules/shop_login/cubit/states.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';
import 'package:shop_app/shared/network/remote/end_points.dart';

class ShopCubitLogin extends Cubit<ShopCubitLoginStates> {
  ShopCubitLogin() : super(ShopCubitLoginInitialState());

  static ShopCubitLogin get(context) => BlocProvider.of(context);
  late ShopLoginModel loginModel;

  bool isPassword = true;
  IconData suffixIcon = Icons.visibility_outlined;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffixIcon =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(ShopCubitLoginChangePasswordVisisbility());
  }

  void userLogin({
    required String email,
    required String password,
  }) {
    emit(ShopCubitLoginIsLoadingState());
    DioHelper.postData(
      url: login,
      data: {
        'email': email,
        'password': password,
      },
    ).then((value) {
      loginModel = ShopLoginModel.fromJson(value.data);
      emit(ShopCubitLoginSuccessState(loginModel));
    }).catchError((error) {
      emit(ShopCubitLoginErrorState(error.toString()));
    });
  }
}
