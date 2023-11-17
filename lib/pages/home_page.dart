import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_first_flutter_app/http/http_client.dart';
import 'package:my_first_flutter_app/repositories/auth_repository.dart';
import 'package:my_first_flutter_app/stores/auth_store.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
 void _checkLogoutResult((bool,String?) result) {
    if (result.$1) {
      GoRouter.of(context).pushReplacement('/onboard');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(result.$2 ?? 'Failed to login user'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final authStore = AuthStore(repository: AuthRepository(client: HttpClient()));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Welcome to Flutter',
            ),
            ElevatedButton(
              onPressed: () async {
                final result = await authStore.logoutUser();
                _checkLogoutResult(result);
              },
              child: const Text('Logout')
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}