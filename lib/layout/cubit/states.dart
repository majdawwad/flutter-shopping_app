import 'package:shop_app/models/shop_favorites_model.dart';
import 'package:shop_app/models/shop_profile_model.dart';

abstract class ShopStates {}

class ShopInitialState extends ShopStates {}

class ShopChangeBottomNavState extends ShopStates {}

class ShopIsLoadingHomeState extends ShopStates {}

class ShopSuccessHomeState extends ShopStates {}

class ShopErrorHomeState extends ShopStates {}

class ShopIsLoadingCategoriesState extends ShopStates {}

class ShopSuccessCategoriesState extends ShopStates {}

class ShopErrorCategoriesState extends ShopStates {}

class ShopSuccessChangeFavoritesState extends ShopStates {
  final ShopFavoritesModel favoritesModel;
  ShopSuccessChangeFavoritesState(this.favoritesModel);
}

class ShopErrorChangeFavoritesState extends ShopStates {}

class ShopChangeFavoritesState extends ShopStates {}

class ShopIsLoadingGetFavoritesState extends ShopStates {}

class ShopSuccessGetFavoritesState extends ShopStates {}

class ShopErrorGetFavoritesState extends ShopStates {}

class ShopIsLoadingGetProfileDataState extends ShopStates {}

class ShopSuccessGetProfileDataState extends ShopStates {}

class ShopErrorGetProfileDataState extends ShopStates {}

class ShopIsLoadingUpdateProfileDataState extends ShopStates {}

class ShopSuccessUpdateProfileDataState extends ShopStates {
  final ShopProfileModel updateShopProfileModel;

  ShopSuccessUpdateProfileDataState(this.updateShopProfileModel);
}

class ShopErrorUpdateProfileDataState extends ShopStates {
  final String error;

  ShopErrorUpdateProfileDataState(this.error);
}

class ShopGetImageState extends ShopStates {}

class ShopIsLoadingNotificationsState extends ShopStates {}

class ShopSuccessNotificationsState extends ShopStates {}

class ShopErrorNotificationsState extends ShopStates {}
