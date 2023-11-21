import 'package:flutter/material.dart';
import 'package:my_first_flutter_app/core/theme/app_colors.dart';
import 'package:my_first_flutter_app/components/ForgotPassword/forgot_password_step_three_form.dart';

class ForgotPasswordStepThreePage extends StatelessWidget {
  const ForgotPasswordStepThreePage({super.key});

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
                'Create a new password',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 28,
                ),
              ),
              const SizedBox(height: 40),
              const ForgotPasswordStepThreeForm(),
            ],
          ),
        ),
      ),
    );
  }
}