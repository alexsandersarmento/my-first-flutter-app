import 'package:flutter/material.dart' hide Router;
import 'package:my_first_flutter_app/core/router/router.dart';
import 'package:my_first_flutter_app/core/theme/theme.dart';
import 'package:my_first_flutter_app/locator.dart';

void main() {
  setupLocator();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: theme,
      routerConfig: Router.instance.router,
    );
  }
}
