import 'package:shop_app/models/shop_login_model.dart';

abstract class ShopCubitRegisterStates {}

class ShopCubitRegisterInitialState extends ShopCubitRegisterStates {}

class ShopCubitRegisterIsLoadingState extends ShopCubitRegisterStates {}

class ShopCubitRegisterSuccessState extends ShopCubitRegisterStates {
  final ShopLoginModel loginModel;
  ShopCubitRegisterSuccessState(this.loginModel);
}

class ShopCubitRegisterErrorState extends ShopCubitRegisterStates {
  final String error;

  ShopCubitRegisterErrorState(this.error);
}

class ShopCubitRegisterChangePasswordVisisbility
    extends ShopCubitRegisterStates {}
