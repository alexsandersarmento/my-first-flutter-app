import 'package:flutter/material.dart';
import 'package:my_first_flutter_app/core/theme/app_colors.dart';
import 'package:my_first_flutter_app/components/ForgotPassword/forgot_password_step_two_form.dart';

class ForgotPasswordStepTwoPage extends StatelessWidget {
  final String? email;

  const ForgotPasswordStepTwoPage({Key? key, required this.email}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.black,
        elevation: 0,
        leading: const BackButton(color: Colors.white),
      ),
      backgroundColor: AppColors.black,
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const SizedBox(height: 20),
              Text(
                'Enter the code sent to',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 28,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                email!,
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w100,
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 40),
              const ForgotPasswordStepTwoForm(),
            ],
          ),
        ),
      ),
    );
  }
}
