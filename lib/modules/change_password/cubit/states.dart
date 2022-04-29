import 'package:shop_app/models/shop_changepassword.model.dart';

abstract class ShopCubitChangePasswordStates {}

class ShopCubitChangePasswordInitialState
    extends ShopCubitChangePasswordStates {}

class ShopCubitChangePasswordIsLoadingState
    extends ShopCubitChangePasswordStates {}

class ShopCubitChangePasswordSuccessState
    extends ShopCubitChangePasswordStates {
  final ShopChangePasswordModel changePasswordModel;
  ShopCubitChangePasswordSuccessState(this.changePasswordModel);
}

class ShopCubitChangePasswordErrorState extends ShopCubitChangePasswordStates {
  final String error;

  ShopCubitChangePasswordErrorState(this.error);
}

class ShopCubitChangeCurrentPasswordVisisbility
    extends ShopCubitChangePasswordStates {}

class ShopCubitChangeNewPasswordVisisbility
    extends ShopCubitChangePasswordStates {}

class ShopCubitRestPasswordIsLoadingState
    extends ShopCubitChangePasswordStates {}

class ShopCubitRestPasswordSuccessState extends ShopCubitChangePasswordStates {
  final ShopChangePasswordModel restPasswordModel;
  ShopCubitRestPasswordSuccessState(this.restPasswordModel);
}

class ShopCubitRestPasswordErrorState extends ShopCubitChangePasswordStates {
  final String error;

  ShopCubitRestPasswordErrorState(this.error);
}
