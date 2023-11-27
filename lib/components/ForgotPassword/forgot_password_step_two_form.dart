import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_first_flutter_app/components/common/button.dart';
import 'package:my_first_flutter_app/core/theme/app_colors.dart';
import 'package:my_first_flutter_app/components/animated_opacity_text_button.dart';
import 'package:my_first_flutter_app/locator.dart';
import 'package:my_first_flutter_app/stores/auth_store.dart';
import 'package:pinput/pinput.dart';

class ForgotPasswordStepTwoForm extends StatefulWidget {
  const ForgotPasswordStepTwoForm({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordStepTwoForm> createState() => _ForgotPasswordStepTwoFormState();
}

class _ForgotPasswordStepTwoFormState extends State<ForgotPasswordStepTwoForm> {
  final TextEditingController pinController = TextEditingController();
  late bool isCodeInvalid = false;

  final authStore = locator<AuthStore>();

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

  PinTheme buildPinTheme(BuildContext context) {
    return PinTheme(
      width: 56,
      height: 56,
      textStyle: Theme.of(context).textTheme.headlineSmall!.copyWith(
        fontWeight: FontWeight.w500,
      ),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        border: Border.all(
          color: Theme.of(context).colorScheme.secondary,
          width: 1,
        ),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 10),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Pinput(
          controller: pinController,
          defaultPinTheme: buildPinTheme(context),
          onChanged: (value) {
            setState(() {
              isCodeInvalid = false;
            });
          },
          errorPinTheme: buildPinTheme(context).copyWith(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              border: Border.all(
                color: Theme.of(context).colorScheme.error,
                width: 1,
              ),
            ),
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
              style: Theme.of(context).textTheme.labelSmall!.copyWith(
                fontWeight: FontWeight.w300,
              ),
            ),
            AnimatedOpacityTextButton(
              onTap: () {},
              child: Text(
                'Resend',
                style: Theme.of(context).textTheme.labelSmall!.copyWith(
                  fontWeight: FontWeight.w500,
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
              return Button(
                onPressed: () {
                  _onVerifyCode(pinController.text);
                },
                text: 'Verify',
                isDisabled: authStore.isLoading,
                isLoading: authStore.isLoading,
              );
            },
          ),
        ),
      ],
    );
  }
}
