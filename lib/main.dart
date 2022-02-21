import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/bloc_observer.dart';
import 'package:shop_app/layout/shop_layout.dart';
import 'package:shop_app/modules/shop_auth/login/login_screen.dart';
import 'package:shop_app/on_boarding/on_boarding.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:shop_app/shared/cubit/states.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';
import 'package:shop_app/shared/styles/thems.dart';

void main() {
  WidgetsFlutterBinding();
  BlocOverrides.runZoned(
    () async {
      DioHelper.init();
      await CacheHelper.init();
      bool? onBoarding = CacheHelper.getData(key: 'onBoarding');
      late Widget widget;
      token = CacheHelper.getData(key: 'token');
      print("=====================================================");
      print(token);
      if (onBoarding != null) {
        if (token != null)
          widget = ShopLayout();
        else {
          widget = LoginScreen();
        }
      } else {
        widget = OnBoarding();
      }

      runApp(MyApp(
        //onBoarding: onBoarding,
        startWidget: widget,
      ));
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  MyApp({/*required this.onBoarding,*/ required this.startWidget});
  //late final bool onBoarding;
  late final Widget startWidget;
  //late final bool onBoarding;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopCubit(),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => ShopCubit()
              ..getHomeData()
              ..getCategoriesData()
              ..getFavoritesData()
              ..getUserData()
              ..getCartsData(),
          ),
        ],
        child: BlocConsumer<ShopCubit, ShopStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return MaterialApp(
              theme: lightThem,
              debugShowCheckedModeBanner: false,
              home: startWidget,
              // onBoarding ? LoginScreen() : OnBoarding(),
            );
          },
        ),
      ),
    );
  }
}



//abanoubezzat50@gmail.com