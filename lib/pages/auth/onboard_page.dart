import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_first_flutter_app/components/common/button.dart';


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
              Button(
                onPressed: () {
                  GoRouter.of(context).push('/login');
                },
                text: 'Login',
              ),
              const SizedBox(height: 20),
              Button(
                onPressed: () {
                  GoRouter.of(context).push('/sign-up');
                },
                text: 'Sign Up',
                isOutline: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
