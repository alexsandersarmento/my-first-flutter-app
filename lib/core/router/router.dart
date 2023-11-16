import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_first_flutter_app/pages/auth/login_page.dart';
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

  GoRouter _router() => GoRouter(
    routes: <RouteBase>[
      GoRoute(
        path: '/',
        builder: (BuildContext context, GoRouterState state) => const HomeScreen(),
        redirect: (context, state) async {
          final token = await repository.getString('token');
          return token == null ? '/login' : null;
        },
        routes: <RouteBase>[
          GoRoute(
            path: 'login',
            builder: (BuildContext context, GoRouterState state) => const LoginPage(),
          ),
          GoRoute(
            path: 'products',
            builder: (BuildContext context, GoRouterState state) => const ProductsPage(),
          ),
          GoRoute(
            path: 'profile',
            builder: (BuildContext context, GoRouterState state) => const ProfilePage(),
          ),
          GoRoute(
            path: 'product-details/:id',
            builder: (BuildContext context, GoRouterState state) {
              String id = state.pathParameters['id'] ?? '';
              return ProductDetailsPage(id: id);
            },
            redirect: (context, state) => state.pathParameters['id'] == null ? '/products' : null,
          )
        ],
      ),
    ],
  );
}