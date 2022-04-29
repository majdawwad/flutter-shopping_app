import 'package:shop_app/models/shop_login_model.dart';

abstract class ShopCubitLoginStates {}

class ShopCubitLoginInitialState extends ShopCubitLoginStates {}

class ShopCubitLoginIsLoadingState extends ShopCubitLoginStates {}

class ShopCubitLoginSuccessState extends ShopCubitLoginStates {
  final ShopLoginModel loginModel;
  ShopCubitLoginSuccessState(this.loginModel);
}

class ShopCubitLoginErrorState extends ShopCubitLoginStates {
  final String error;

  ShopCubitLoginErrorState(this.error);
}

class ShopCubitLoginChangePasswordVisisbility extends ShopCubitLoginStates {}
