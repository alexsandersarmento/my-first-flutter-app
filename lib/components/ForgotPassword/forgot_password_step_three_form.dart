import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_first_flutter_app/components/error_dialog.dart';
import 'package:my_first_flutter_app/core/theme/app_colors.dart';
import 'package:my_first_flutter_app/locator.dart';
import 'package:my_first_flutter_app/stores/auth_store.dart';
import 'package:my_first_flutter_app/components/custom_text_form_field.dart';

class ForgotPasswordStepThreeForm extends StatefulWidget {
  const ForgotPasswordStepThreeForm({super.key});

  @override
  State<ForgotPasswordStepThreeForm> createState() => _ForgotPasswordStepThreeFormState();
}

class _ForgotPasswordStepThreeFormState extends State<ForgotPasswordStepThreeForm> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final authStore = locator<AuthStore>();

  bool _isPasswordVisible = false;

  bool _checkFormValidation() {
    return _formKey.currentState!.validate();
  }

  void _onResetPasswordSuccess() {
    GoRouter.of(context).push('/home');
  }

  void _onResetPasswordError(String message) {
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
              color: Colors.white),
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

                    final password = _passwordController.text;
                    final confirmPassword = _confirmPasswordController.text;

                    return authStore.resetPassword(password, confirmPassword, _onResetPasswordSuccess, _onResetPasswordError);  
                  },
                  child: authStore.isLoading ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(color: AppColors.black)
                  ) : const Text('Reset password', style: TextStyle(color: AppColors.black)),
                );
              },
            ),
          ),
        ],
      )
    );
  }
}