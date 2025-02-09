import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:project_bloc/src/create_project/ui/create_project_screen.dart';
import '../../src/create_product/ui/create_product_screen.dart';
import '../../src/login/ui/login_screen.dart';
import '../../src/product_list/ui/product_list_screen.dart';
import '../../src/project_list/ui/project_list_screen.dart';
import '../../src/search_project/ui/search_project_screen.dart';
import '../../src/splash/splash.dart';
import '../../src/user_list/ui/user_list_screen.dart';
import 'route_name.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoute.splashScreenPath:
        return _pageTransition(child: const SplashScreen());
      case AppRoute.userListScreenPath:
        return _pageTransition(child: const UserListScreen());
      case AppRoute.createProjectScreenPath:
        return _pageTransition(child: const CreateProjectScreen());
      case AppRoute.loginScreenPath:
        return _pageTransition(child: const LoginScreen());
      case AppRoute.projectListScreenPath:
        return _pageTransition(child: const ProjectListScreen());
      case AppRoute.searchProjectListScreenPath:
        return _pageTransition(child: const ProjectSearchView());
      case AppRoute.createProductScreenPath:
        return _pageTransition(child: const CreateProductScreen());
      case AppRoute.productListScreenPath:
        return _pageTransition(child: const ProductListScreen());

      default:
        return _pageTransition(
          child: Scaffold(
            appBar: AppBar(title: const Text("ERROR")),
            body: const Center(child: Text("ERROR")),
          ),
        );
    }
  }

  static PageTransition<dynamic> _pageTransition({
    required Widget child,
    PageTransitionType? type,
  }) {
    return PageTransition(
      duration: const Duration(milliseconds: 350),
      reverseDuration: const Duration(milliseconds: 350),
      type: type ?? PageTransitionType.rightToLeft,
      child: child,
    );
  }
}
