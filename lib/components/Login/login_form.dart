import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_first_flutter_app/core/theme/app_colors.dart';
import 'package:my_first_flutter_app/http/http_client.dart';
import 'package:my_first_flutter_app/repositories/auth_repository.dart';
import 'package:my_first_flutter_app/stores/auth_store.dart';
import 'package:my_first_flutter_app/components/custom_text_form_field.dart';
import 'package:my_first_flutter_app/components/error_dialog.dart';
import 'package:my_first_flutter_app/components/animated_opacity_text_button.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final authStore = AuthStore(repository: AuthRepository(client: HttpClient()));

  bool _isPasswordVisible = false;

  bool _checkFormValidation() {
    return _formKey.currentState!.validate();
  }

  void _onLoginSuccess() {
    GoRouter.of(context).push('/home');
  }

  void _onLoginError(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ErrorDialog(
          title: 'Erro',
          content: message,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          CustomTextFormField(
            controller: _emailController,
            labelText: 'Email',
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your email';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          CustomTextFormField(
            controller: _passwordController,
            labelText: 'Password',
            keyboardType: TextInputType.visiblePassword,
            obscureText: !_isPasswordVisible,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your password';
              }
              return null;
            },
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
          const SizedBox(height: 14),
          Align(
            alignment: Alignment.centerRight,
            child: AnimatedOpacityTextButton(
              onTap: () {
                GoRouter.of(context).push('/forgot-password-step-one');
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
                    final isFormValid = _checkFormValidation();
                    if (!isFormValid) {
                        ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Please fill in all fields'),
                        ),
                      );
                      return;
                    }

                    final email = _emailController.text;
                    final password = _passwordController.text;
                          
                    return authStore.loginUser(email, password, _onLoginSuccess, _onLoginError);
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
      )
    );
  }
}