import 'package:flutter/material.dart' hide Router;
import 'package:my_first_flutter_app/core/router/router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: Router.instance.router,
    );
  }
}
