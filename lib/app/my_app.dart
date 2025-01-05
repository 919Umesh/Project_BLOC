import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oktoast/oktoast.dart';
import 'package:project_bloc/src/user_list/bloc/user_list_bloc.dart';
import '../src/splash/splash.dart';
import 'app.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => SplashBloc()),
        BlocProvider(create: (context) => UserListBloc()),
      ],
      child: OKToast(
        child: MaterialApp(
          navigatorKey: AppInfo.navigatorKey,
          title: AppInfo.appName,
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
              seedColor: kPrimaryColor,
              primary: kPrimaryColor,
            ),
            useMaterial3: true,
          ),
          initialRoute: AppRoute.splashScreenPath,
          onGenerateRoute: RouteGenerator.generateRoute,
        ),
      ),
    );
  }
}
