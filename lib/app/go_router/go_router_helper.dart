import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:project_bloc/app/go_router/go_router_name.dart';
import 'package:project_bloc/src/create_project/ui/create_project_screen.dart';
import '../../src/khalti/khalti_page.dart';
import '../../src/login/ui/login_screen.dart';
import '../../src/product_list/ui/product_list_screen.dart';
import '../../src/project_list/ui/project_list_screen.dart';
import '../../src/search_project/ui/search_project_screen.dart';
import '../../src/splash/splash.dart';
import '../../src/user_list/ui/user_list_screen.dart';
import '../../src/user_list/ui/user_local.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: AppRoute.splashScreenPath,
      builder: (context, state) => const SplashScreen(),
    ),

    GoRoute(
      path: AppRoute.userListScreenPath,
      builder: (context, state) => const UserListScreen(),
    ),

    GoRoute(
      path: AppRoute.createProjectScreenPath,
      builder: (context, state) => const CreateProjectScreen(),
    ),
    GoRoute(
      path: AppRoute.loginScreenPath,
      builder: (context, state) => const LoginScreen(),
    ),

    GoRoute(
      path: AppRoute.projectListScreenPath,
      builder: (context, state) => const ProjectListScreen(),
    ),
    GoRoute(
      path: AppRoute.searchProjectListScreenPath,
      builder: (context, state) => const ProjectSearchView(),
    ),
    GoRoute(
      path: AppRoute.productListScreenPath,
      builder: (context, state) => const ProductListScreen(),
    ),
    GoRoute(
      path: AppRoute.userListLocal,
      builder: (context, state) => const UserListLocal(),
    ),
    GoRoute(
      path: AppRoute.khaltiAppPath,
      builder: (context, state) => const KhaltiPaymentPage(),
    ),
  ],
  errorBuilder: (context, state) => Scaffold(
    appBar: AppBar(title: const Text("ERROR")),
    body: Center(child: Text(state.error.toString())),
  ),
);