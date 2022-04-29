import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/models/shop_categories_model.dart';
import 'package:shop_app/models/shop_favorites_model.dart';
import 'package:shop_app/models/shop_getfavorites_model.dart';
import 'package:shop_app/models/shop_home_model.dart';
import 'package:shop_app/models/shop_notification_model.dart';
import 'package:shop_app/models/shop_profile_model.dart';
import 'package:shop_app/modules/categories/categories_screen.dart';
import 'package:shop_app/modules/favorites/favorites_screen.dart';
import 'package:shop_app/modules/prodacts/prodacts_screen.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';
import 'package:shop_app/shared/network/remote/end_points.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialState());

  static ShopCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  ShopHomeModel? homeModel;
  ShopCategoriesModel? categoyModel;
  ShopFavoritesModel? favoritesModel;
  ShopGetFavoritesModel? shopGetFavoritesModel;
  ShopProfileModel? profileModel;
  ShopNotificationModel? notificationModel;
  File? imageFile;
  String? baseImage;
  final imagepicker = ImagePicker();

  List<Widget> bottomScreen = [
    const ProductsScreen(),
    const CategoriesScreen(),
    const FavoritesScreen(),
  ];

  void changebottomnav(int index) {
    currentIndex = index;
    emit(ShopChangeBottomNavState());
  }

  Map<int, bool> favories = {};

  void getHomeData() {
    emit(ShopIsLoadingHomeState());
    DioHelper.getData(
      url: home,
      token: token,
    ).then((value) {
      homeModel = ShopHomeModel.fromJson(value.data);
      for (var element in homeModel!.data!.products) {
        favories.addAll({
          element.id!: element.inFavorites!,
        });
      }

      emit(ShopSuccessHomeState());
    }).catchError((error) {
      emit(ShopErrorHomeState());
    });
  }

  void getCategories() {
    emit(ShopIsLoadingCategoriesState());

    DioHelper.getData(
      url: getcategries,
    ).then((value) {
      categoyModel = ShopCategoriesModel.fromJson(value.data);
      emit(ShopSuccessCategoriesState());
    }).catchError((error) {
      emit(ShopErrorCategoriesState());
    });
  }

  void changeFavorites(int productId) {
    favories[productId] = !favories[productId]!;
    emit(ShopChangeFavoritesState());
    DioHelper.postData(
      url: favoriets,
      token: token,
      data: {
        'product_id': productId,
      },
    ).then((value) {
      favoritesModel = ShopFavoritesModel.fromJson(value.data);
      if (!favoritesModel!.status!) {
        favories[productId] = !favories[productId]!;
      } else {
        getFavoritesData();
      }
      emit(ShopSuccessChangeFavoritesState(favoritesModel!));
    }).catchError((error) {
      favories[productId] = !favories[productId]!;
      emit(ShopErrorChangeFavoritesState());
    });
  }

  void getFavoritesData() {
    emit(ShopIsLoadingGetFavoritesState());
    DioHelper.getData(
      url: favoriets,
      token: token,
    ).then((value) {
      shopGetFavoritesModel = ShopGetFavoritesModel.fromJson(value.data);

      emit(ShopSuccessGetFavoritesState());
    }).catchError((error) {
      emit(ShopErrorGetFavoritesState());
    });
  }

  void getProfileData() {
    emit(ShopIsLoadingGetProfileDataState());
    DioHelper.getData(
      url: profile,
      token: token,
    ).then((value) {
      profileModel = ShopProfileModel.fromJson(value.data);

      emit(ShopSuccessGetProfileDataState());
    }).catchError((error) {
      emit(ShopErrorGetProfileDataState());
    });
  }

  void putProfileData({
    String? name,
    String? phone,
    String? email,
    String? image,
  }) {
    emit(ShopIsLoadingUpdateProfileDataState());

    DioHelper.putData(
      url: update,
      token: token,
      data: {
        "name": name,
        "phone": phone,
        "email": email,
        "image": image,
      },
    ).then((value) {
      profileModel = ShopProfileModel.fromJson(value.data);
      emit(ShopSuccessUpdateProfileDataState(profileModel!));
    }).catchError((error) {
      emit(ShopErrorUpdateProfileDataState(error.toString()));
    });
  }

  void getImage({
    required ImageSource imageSource,
  }) async {
    var pickedImage = await imagepicker.pickImage(source: imageSource);
    if (pickedImage != null) {
      imageFile = File(pickedImage.path);
      baseImage = base64Encode(imageFile!.readAsBytesSync());
      emit(ShopGetImageState());
    } else {}
  }

  void getNotifications() {
    emit(ShopIsLoadingNotificationsState());
    DioHelper.getData(
      url: notifications,
      token: token,
    ).then((value) {
      notificationModel = ShopNotificationModel.fromJson(value.data);

      emit(ShopSuccessNotificationsState());
    }).catchError((error) {
      printFullText(error.toString());
      emit(ShopErrorNotificationsState());
    });
  }
}
