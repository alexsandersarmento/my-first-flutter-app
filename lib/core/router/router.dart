import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_first_flutter_app/pages/auth/onboard_page.dart';
import 'package:my_first_flutter_app/pages/auth/login_page.dart';
import 'package:my_first_flutter_app/pages/auth/signup_page.dart';
import 'package:my_first_flutter_app/pages/product_details.dart';
import 'package:my_first_flutter_app/pages/products_page.dart';
import 'package:my_first_flutter_app/pages/profile_page.dart';
import 'package:my_first_flutter_app/repositories/shared_repository.dart';
import 'package:my_first_flutter_app/screens/home_screen.dart';

class Router {
  static Router? _instance;
  static Router get instance {
    _instance ??= Router._();
    return _instance!;
  }
  
  final ISharedPreferencesRepository repository = SharedPreferencesRepository();

  Router._();

  GoRouter get router => _router();

  Future<String?> _redirectIfTokenIsNull() async {
    final token = await repository.getString('token');
    return token == null ? '/onboard' : null;
  }

  CustomTransitionPage buildPageWithDefaultTransition<T>({
    required BuildContext context, 
    required GoRouterState state, 
    required Widget child,
  }) {
    return CustomTransitionPage<T>(
      key: state.pageKey,
      child: child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) => 
        FadeTransition(opacity: animation, child: child),
    );
  }

  GoRouter _router() => GoRouter(
    routes: <RouteBase>[
      GoRoute(
        path: '/',
        builder: (BuildContext context, GoRouterState state) => const OnboardPage(),
        pageBuilder: (context, state) => buildPageWithDefaultTransition(
          context: context,
          state: state,
          child: const OnboardPage(),
        ),
        routes: <RouteBase>[
          GoRoute(
            path: 'onboard',
            pageBuilder: (context, state) => buildPageWithDefaultTransition(
              context: context,
              state: state,
              child: const OnboardPage(),
            )
          ),
          GoRoute(
            path: 'login',
            pageBuilder: (context, state) => buildPageWithDefaultTransition(
              context: context,
              state: state,
              child: const LoginPage(),
            )
          ),
          GoRoute(
            path: 'signup',
            pageBuilder: (context, state) => buildPageWithDefaultTransition(
              context: context,
              state: state,
              child: const SignUpPage(),
            )
          ),
          GoRoute(
            path: 'home',
            pageBuilder: (context, state) => buildPageWithDefaultTransition(
              context: context,
              state: state,
              child: const HomeScreen(),
            ),
            redirect: (context, state) async => _redirectIfTokenIsNull(),
          ),
          GoRoute(
            path: 'products',
            pageBuilder: (context, state) => buildPageWithDefaultTransition(
              context: context,
              state: state,
              child: const ProductsPage(),
            ),
            redirect: (context, state) async => _redirectIfTokenIsNull(),
          ),
          GoRoute(
            path: 'profile',
            pageBuilder: (context, state) => buildPageWithDefaultTransition(
              context: context,
              state: state,
              child: const ProfilePage(),
            ),
            redirect: (context, state) async => _redirectIfTokenIsNull(),
          ),
          GoRoute(
            path: 'product-details/:id',
            pageBuilder: (context, state) => buildPageWithDefaultTransition(
              context: context,
              state: state,
              child: ProductDetailsPage(id: state.pathParameters['id'] ?? ''),
            ),
            redirect: (context, state) {
              _redirectIfTokenIsNull();
              state.pathParameters['id'] == null ? '/products' : null;
            }
          )
        ],
      ),
    ],
  );
}