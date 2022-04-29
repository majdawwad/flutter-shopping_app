import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/home_layout_shop.dart';
import 'package:shop_app/modules/change_password/cubit/cubit.dart';
import 'package:shop_app/modules/on_boarding/on_boarding_screen.dart';
import 'package:shop_app/modules/shop_login/shop_login_screen.dart';
import 'package:shop_app/shared/bloc_observer.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/cubit/cubit_mode.dart';
import 'package:shop_app/shared/cubit/states_mode.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';
import 'package:shop_app/shared/styles/themes.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  bool? isDark = CacheHelper.getData(key: 'isDark');
  bool? onboard = CacheHelper.getData(key: 'onBoarding');
  token = CacheHelper.getData(key: 'token');
  late Widget widgwt;

  if (onboard != null) {
    if (token != null) {
      widgwt = const HomeLayoutShop();
    } else {
      widgwt = const ShopLoginScreen();
    }
  } else {
    widgwt = const OnBoardingScreen();
  }

  runApp(MyApp(
    isDark: isDark,
    widgwt: widgwt,
  ));
}

class MyApp extends StatelessWidget {
  final bool? isDark;
  final Widget? widgwt;
  const MyApp({
    Key? key,
    this.isDark,
    this.widgwt,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AppCubitMode()..changemode(formShared: isDark),
        ),
        BlocProvider(
          create: (context) => ShopCubit()
            ..getHomeData()
            ..getCategories()
            ..getFavoritesData()
            ..getProfileData()
            ..getNotifications(),
        ),
        BlocProvider(
          create: (context) => ShopCubitChangePassword(),
        ),
      ],
      child: BlocConsumer<AppCubitMode, AppCubitModeStates>(
        listener: (context, state) {},
        builder: (context, state) {
          AppCubitMode cubit = AppCubitMode.get(context);
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: cubit.isDark ? ThemeMode.dark : ThemeMode.light,
            home: widgwt!,
          );
        },
      ),
    );
  }
}
