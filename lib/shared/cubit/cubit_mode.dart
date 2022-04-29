import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shared/cubit/states_mode.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';

class AppCubitMode extends Cubit<AppCubitModeStates> {
  AppCubitMode() : super(AppCubitModeInitialState());

  static AppCubitMode get(context) => BlocProvider.of(context);

  bool isDark = false;

  void changemode({
    bool? formShared,
  }) {
    if (formShared != null) {
      isDark = formShared;
      emit(AppCubitModeChangeModeState());
    } else {
      isDark = !isDark;
      CacheHelper.putBoolean(key: 'isDark', value: isDark).then((value) {
        emit(AppCubitModeChangeModeState());
      }).catchError((error) {
        emit(AppCubitModeChangeModeErrorState(error.toString()));
      });
    }
  }
}
