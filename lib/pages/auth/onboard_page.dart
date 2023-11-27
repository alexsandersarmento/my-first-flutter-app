import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_first_flutter_app/core/theme/app_colors.dart';

class OnboardPage extends StatelessWidget {
  const OnboardPage({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 200,
                height: 200,
                child: Theme.of(context).brightness == Brightness.light
                    ? Image.asset('assets/images/logo.png')
                    : Image.asset('assets/images/logo_dark.png'),
              ),
              const SizedBox(height: 60),
              ElevatedButton(
                onPressed: () {
                  GoRouter.of(context).push('/login');
                },
                style: Theme.of(context).elevatedButtonTheme.style,
                child: Text(
                  'Login',
                  style: TextStyle(
                    color: Theme.of(context).textTheme.bodySmall?.backgroundColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(height: 20),
               OutlinedButton(
                onPressed: () {
                  GoRouter.of(context).push('/sign-up');
                },
                style: Theme.of(context).outlinedButtonTheme.style,
                child: Text(
                  'Sign up',
                  style: TextStyle(
                    color: Theme.of(context).textTheme.bodySmall?.color,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
