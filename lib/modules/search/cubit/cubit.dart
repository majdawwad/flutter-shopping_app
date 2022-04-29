import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/shop_search_model.dart';
import 'package:shop_app/modules/search/cubit/states.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';
import 'package:shop_app/shared/network/remote/end_points.dart';

class ShopSearchCubit extends Cubit<ShopSearchStates> {
  ShopSearchCubit() : super(ShopSearchInitialStates());

  static ShopSearchCubit get(context) => BlocProvider.of(context);

  ShopSearchModel? searchModel;

  void search(String text) {
    emit(ShopSearchIsLoadingStates());

    DioHelper.postData(
      url: searchproducts,
      data: {
        'text': text,
      },
    ).then((value) {
      searchModel = ShopSearchModel.fromJson(value.data);
      emit(ShopSearchSuccessStates());
    }).catchError((error) {
      emit(ShopSearchErrorStates());
    });
  }
}
