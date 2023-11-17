import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_first_flutter_app/core/theme/app_colors.dart';
import 'package:my_first_flutter_app/http/http_client.dart';
import 'package:my_first_flutter_app/repositories/auth_repository.dart';
import 'package:my_first_flutter_app/stores/auth_store.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isPasswordVisible = false;

  final authStore = AuthStore(repository: AuthRepository(client: HttpClient()));

  void _checkLoginResult((bool,String?) result) {
    if (result.$1) {
      GoRouter.of(context).push('/');
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.black,
        elevation: 0,
        leading: const BackButton(color: Colors.white),
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(20),
          color: AppColors.black,
          child: Column(
            children: [
              const SizedBox(height: 20),
              Text(
                'Welcome,',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 28,
                ),
              ),
              Text(
                'Glad to see you!',
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w100,
                  fontSize: 28,
                ),
              ),
              const SizedBox(height: 40),
              SizedBox(
                width: double.infinity,
                height: 44,
                child: TextField(
                  controller: _emailController,
                  style: MaterialStateTextStyle.resolveWith((states) => Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w100,
                  )),
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    labelStyle: TextStyle(color: Colors.white),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 1),
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 1),
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 44,
                child: TextField(
                  controller: _passwordController,
                  style: MaterialStateTextStyle.resolveWith((states) => Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w100,
                  )),
                  decoration: InputDecoration(
                    labelText: 'Password',
                    labelStyle: const TextStyle(color: Colors.white),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 1),
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 1),
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _isPasswordVisible = !_isPasswordVisible;
                        });
                      },
                      icon: Icon(
                        _isPasswordVisible  ? Icons.visibility : Icons.visibility_off,
                      color: Colors.white),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    GoRouter.of(context).push('/forgot-password');
                  },
                  child: Text(
                    'Forgot password?',
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w100,
                      fontSize: 14,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 44,
                child: ListenableBuilder(
                  listenable: authStore,
                  builder: (BuildContext context, Widget? child) {
                    return ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: () async {
                          final email = _emailController.text;
                          final password = _passwordController.text;
                                
                          final result = await authStore.loginUser(email, password);
                          _checkLoginResult(result);
                        },
                        child: authStore.isLoading ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(color: AppColors.black)
                        ) : const Text('Login', style: TextStyle(color: AppColors.black)),
                      );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
