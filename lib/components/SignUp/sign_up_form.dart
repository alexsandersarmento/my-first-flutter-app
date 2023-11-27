import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_first_flutter_app/components/error_dialog.dart';
import 'package:my_first_flutter_app/locator.dart';
import 'package:my_first_flutter_app/stores/auth_store.dart';
import 'package:my_first_flutter_app/components/custom_text_form_field.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final authStore = locator<AuthStore>();

  bool _isPasswordVisible = false;

  bool _checkFormValidation() {
    return _formKey.currentState!.validate();
  }

  void _onSignUpSuccess() {
    GoRouter.of(context).push('/home');
  }

  void _onSignUpError(String message) {
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
              color: Theme.of(context).iconTheme.color),
            ),
          ),
          const SizedBox(height: 20),
          CustomTextFormField(
            controller: _confirmPasswordController,
            labelText: 'Confirm Password',
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
              color: Theme.of(context).iconTheme.color),
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
                  style: Theme.of(context).elevatedButtonTheme.style,
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
                    final confirmPassword = _confirmPasswordController.text;
                          
                    return authStore.signUpUser(email, password, confirmPassword, _onSignUpSuccess, _onSignUpError);
                  },
                  child: authStore.isLoading ? SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      color: Theme.of(context).textTheme.bodySmall?.backgroundColor
                    ),
                  ) : const Text(
                    'Sign Up',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      )
    );
  }
}