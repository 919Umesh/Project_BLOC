import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../app/app.dart';
import '../../../core/core.dart';
import '../bloc/splash_bloc.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<SplashBloc>(context).add(SplashScreenStarted());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SplashBloc, SplashState>(
      builder: (context, state) {
        return Scaffold(
          body: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              GradientContainer(
                child: Center(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Hero(
                          tag: AppAssets.appIcon,
                          child: SvgPicture.asset(
                            AppInfo.appIcon,
                            height: 100.0,
                          ),
                        ),
                        10.pHeight,
                        const Text(AppInfo.appName, style: kWhiteTitleText),
                      ],
                    ),
                  ),
                ),
              ),
              const Text(
                AppInfo.orgFullName,
                style: kWhiteSubTitleText,
                textAlign: TextAlign.center,
              ).paddingVertical(10.0),
            ],
          ),
        );
      },
      listener: (context, state) {
        if (state is SplashNavigateToIndex) {
          Navigator.pushReplacementNamed(context, AppRoute.splashScreen);
        } else if (state is SplashNavigateToLogin) {
          Navigator.pushReplacementNamed(context, AppRoute.splashScreen);
        } else {
          Navigator.pushReplacementNamed(context, AppRoute.splashScreen);
        }
      },
    );
  }
}
