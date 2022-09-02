import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_api/modules/shop_app/login/cubit/cubit.dart';
import 'package:shop_api/modules/shop_app/login/shop_login_screen.dart';
import 'package:shop_api/shared/bloc_observer.dart';
import 'package:shop_api/shared/network/local/cache_helper.dart';
import 'package:shop_api/shared/network/remote/dio_helper.dart';
import 'package:shop_api/styles/themes.dart';

import 'layouts/shop_app/cubit/cubit.dart';
import 'layouts/shop_app/cubit/state.dart';
import 'layouts/shop_app/shop_layout.dart';
import 'modules/shop_app/on_boarding/on_boarding_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  DioHelper.init();
  await CacheHelper.init();
  final Widget widget;
  String? Token;
  final bool? isDark = CacheHelper.getData(key: 'isDark');
  final bool? onBoarding = CacheHelper.getData(key: 'onBoarding');
  Token = CacheHelper.getData(key: 'token');
  print(Token);

  if (onBoarding != null) {
    if (Token != null) {
      widget = const ShopLayout();
      print('Token: Not Null');
    } else {
      widget = ShopLoginScreen();
      print('Token: Null');
    }
  } else {
    widget = OnBoardingScreen();
    print('On Boarding');
  }

  BlocOverrides.runZoned(
    () => runApp(MyApp(isDark, onBoarding, widget)),
    blocObserver: MyBlocObserver(),
  );

  // BlocOverrides.runZoned(
  //       () {
  //     // Use cubits...
  //         CounterCubit();
  //   },
  //   blocObserver: MyBlocObserver(),
  // );
  // runApp(MyApp());
}

//Stateless
//Stateful

// Class MyApp
class MyApp extends StatelessWidget {
  final bool? isDark;
  final bool? onBoarding;

  final Widget? widget;

  MyApp(this.isDark, this.onBoarding, this.widget);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ShopLoginCubit()),
        BlocProvider(
            create: (context) => ShopAppCubit()
              ..getHomeData()
              ..getCategoriesData()
              ..getFavoritesData()
              ..getUserData()),
      ],
      child: BlocConsumer<ShopAppCubit, ShopAppStates>(
        builder: (context, state) => MaterialApp(
          //Light Theme
          theme: lightTheme,
          //Dark Theme
          darkTheme: darkTheme,
          //Default Theme
          themeMode: ThemeMode.light,
          debugShowCheckedModeBanner: false,
          home: widget,
          //  themeMode: AppCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
        ),
        listener: (context, state) {},
      ),
    );
  }
}
