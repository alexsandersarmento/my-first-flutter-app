import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_first_flutter_app/core/theme/app_colors.dart';
import 'package:my_first_flutter_app/components/animated_opacity_text_button.dart';
import 'package:my_first_flutter_app/http/http_client.dart';
import 'package:my_first_flutter_app/stores/auth_store.dart';
import 'package:pinput/pinput.dart';

import '../../repositories/auth_repository.dart';

class ForgotPasswordStepTwoForm extends StatefulWidget {
  const ForgotPasswordStepTwoForm({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordStepTwoForm> createState() => _ForgotPasswordStepTwoFormState();
}

class _ForgotPasswordStepTwoFormState extends State<ForgotPasswordStepTwoForm> {
  final TextEditingController pinController = TextEditingController();
  late bool isCodeInvalid = false;

  final authStore = AuthStore(repository: AuthRepository(client: HttpClient()));

  final defaultPinTheme = PinTheme(
    width: 56,
    height: 56,
    textStyle: const TextStyle(
      color: Colors.white,
      fontSize: 24,
      fontWeight: FontWeight.bold,
    ),
    decoration: BoxDecoration(
      borderRadius: const BorderRadius.all(Radius.circular(8)),
      border: Border.all(
        color: Colors.white,
        width: 1,
      ),
    ),
    margin: const EdgeInsets.symmetric(horizontal: 10),
  );


  void _onVerifyCodeSuccess() {
    GoRouter.of(context).push('/forgot-password-step-three');
  }

  void _onVerifyCodeError(String message) {
    setState(() {
      isCodeInvalid = true;
    });
  }

  void _onVerifyCode(String value) {
    authStore.verifyCode(value, _onVerifyCodeSuccess, _onVerifyCodeError);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Pinput(
          controller: pinController,
          defaultPinTheme: defaultPinTheme,
          onChanged: (value) {
            setState(() {
              isCodeInvalid = false;
            });
          },
          errorPinTheme: defaultPinTheme.copyBorderWith(
            border: Border.all(color: Colors.redAccent),
          ),
          forceErrorState: isCodeInvalid,
          errorText: 'Invalid code',
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Didn\'t receive the code? ',
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w100,
                fontSize: 16,
              ),
            ),
            AnimatedOpacityTextButton(
              onTap: () {},
              child: Text(
                'Resend',
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
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
                onPressed: () {
                  _onVerifyCode(pinController.text);
                },
                child: authStore.isLoading ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(color: AppColors.black)
                ) : const Text('Verify', style: TextStyle(color: AppColors.black)),
              );
            },
          ),
        ),
      ],
    );
  }
}
