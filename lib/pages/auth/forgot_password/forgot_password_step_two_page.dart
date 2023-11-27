import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_first_flutter_app/components/ForgotPassword/forgot_password_step_two_form.dart';

class ForgotPasswordStepTwoPage extends StatelessWidget {
  final String? email;

  const ForgotPasswordStepTwoPage({Key? key, required this.email}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            GoRouter.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Theme.of(context).iconTheme.color,
          ),
        ),
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const SizedBox(height: 20),
              Text(
                'Enter the code sent to',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 10),
              Text(
                email!,
                style: Theme.of(context).textTheme.labelMedium,
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
