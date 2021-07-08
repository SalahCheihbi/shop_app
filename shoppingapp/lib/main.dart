import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppingapp/layout/cubit/cubit.dart';
import 'package:shoppingapp/layout/cubit/states.dart';

import 'package:shoppingapp/modules/on_boarding/on_boarding_screen.dart';
import 'package:shoppingapp/shared/bloc_obsever.dart';
import 'package:shoppingapp/shared/compontens/constants.dart';
import 'package:shoppingapp/shared/network/local/cache_helper.dart';
import 'package:shoppingapp/shared/network/remote/dio_helper.dart';
import 'package:shoppingapp/shared/styles/theme.dart';
import 'modules/login/shop_app_login_screen.dart';
import 'layout/home_layout.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.inti();

  await CacheHelper.init();
  Widget widget;
  bool? onBoarding = CacheHelper.getData(key: 'onBoarding');
  token = CacheHelper.getData(key: 'token');

  if (onBoarding != null) {
    if (token != null)
      widget = ShopLayout();
    else
      widget = ShopLoginScreen();
  } else {
    widget = OnBoardingScreen();
  }

  runApp(MyApp(
    startWidget: widget,
  ));
}

class MyApp extends StatelessWidget {
  final Widget? startWidget;
  MyApp({this.startWidget});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (context) => ShopCubit()
                ..getHomeData()
                ..getCategoriesData()
                ..getFavorites()
                ..getUserData())
        ],
        child: BlocConsumer<ShopCubit, ShopStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Shop_app',
              theme: lightTheme,
              home: startWidget,
            );
          },
        ));
  }
}
