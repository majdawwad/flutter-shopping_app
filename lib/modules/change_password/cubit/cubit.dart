import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/shop_changepassword.model.dart';
import 'package:shop_app/modules/change_password/cubit/states.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';
import 'package:shop_app/shared/network/remote/end_points.dart';

class ShopCubitChangePassword extends Cubit<ShopCubitChangePasswordStates> {
  ShopCubitChangePassword() : super(ShopCubitChangePasswordInitialState());

  static ShopCubitChangePassword get(context) => BlocProvider.of(context);
  ShopChangePasswordModel? changePasswordModel;
  ShopChangePasswordModel? restPasswordModel;

  bool isCurrentPassword = true;
  IconData suffixIconCurrent = Icons.visibility_outlined;
  bool isNewPassword = true;
  IconData suffixIconNew = Icons.visibility_outlined;

  void changeCurrentPasswordVisibility() {
    isCurrentPassword = !isCurrentPassword;
    suffixIconCurrent = isCurrentPassword
        ? Icons.visibility_outlined
        : Icons.visibility_off_outlined;
    emit(ShopCubitChangeCurrentPasswordVisisbility());
  }

  void changeNewPasswordVisibility() {
    isNewPassword = !isNewPassword;
    suffixIconNew = isNewPassword
        ? Icons.visibility_outlined
        : Icons.visibility_off_outlined;
    emit(ShopCubitChangeNewPasswordVisisbility());
  }

  void changePassword({
    required String currentPass,
    required String newPass,
  }) {
    emit(ShopCubitChangePasswordIsLoadingState());
    DioHelper.postData(
      url: changepassword,
      token: token,
      data: {
        "current_password": currentPass,
        "new_password": newPass,
      },
    ).then((value) {
      changePasswordModel = ShopChangePasswordModel.fromJson(value.data);

      emit(ShopCubitChangePasswordSuccessState(changePasswordModel!));
    }).catchError((error) {
      printFullText(error.toString());
      emit(ShopCubitChangePasswordErrorState(error.toString()));
    });
  }

  void restPassword({
    required String email,
    required String code,
    required String password,
  }) {
    emit(ShopCubitRestPasswordIsLoadingState());
    DioHelper.postData(url: resetpassword, data: {
      'email': email,
      'code': code,
      'password': password,
    }).then((value) {
      restPasswordModel = ShopChangePasswordModel.fromJson(value.data);
      printFullText(value.data.toString());
      emit(ShopCubitRestPasswordSuccessState(restPasswordModel!));
    }).catchError((error) {
      //printFullText(error.toString());
      emit(ShopCubitRestPasswordErrorState(error.toString()));
    });
  }
}
