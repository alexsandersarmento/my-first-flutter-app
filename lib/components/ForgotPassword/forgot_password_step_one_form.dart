import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_first_flutter_app/core/theme/app_colors.dart';
import 'package:my_first_flutter_app/components/custom_text_form_field.dart';
import 'package:my_first_flutter_app/components/animated_opacity_text_button.dart';
import 'package:my_first_flutter_app/http/http_client.dart';
import 'package:my_first_flutter_app/stores/auth_store.dart';
import 'package:my_first_flutter_app/components/error_dialog.dart';

import '../../repositories/auth_repository.dart';

class ForgotPasswordStepOneForm extends StatefulWidget {
  const ForgotPasswordStepOneForm({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordStepOneForm> createState() => _ForgotPasswordStepOneFormState();
}

class _ForgotPasswordStepOneFormState extends State<ForgotPasswordStepOneForm> {
  final TextEditingController _emailController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final authStore = AuthStore(repository: AuthRepository(client: HttpClient()));

  bool _checkFormValidation() {
    return _formKey.currentState!.validate();
  }

  void _onForgotPasswordSuccess() {
    // '/product-details/${item.id}',
    GoRouter.of(context).push('/forgot-password-step-two/${_emailController.text}');
  }

  void _onForgotPasswordError(String message) {
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
              // Add your email validation logic here if needed
              return null;
            },
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
                    return authStore.forgotPassword(email, _onForgotPasswordSuccess, _onForgotPasswordError);
                  },
                  child: authStore.isLoading ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(color: AppColors.black)
                  ) : const Text('Continue', style: TextStyle(color: AppColors.black)),
                );
              },
            ),
          ),
          const SizedBox(height: 20),
          Align(
            alignment: Alignment.centerRight,
            child: AnimatedOpacityTextButton(
              onTap: () {
                GoRouter.of(context).pop(); // Navigate back to login page
              },
              child: const Text(
                'Back to Login',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w100,
                  fontSize: 14,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
