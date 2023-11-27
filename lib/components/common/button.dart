import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String text;
  final Function onPressed;
  final bool isDisabled;
  final bool isOutline;
  final bool isLoading;
  
  const Button({
    Key? key,
    required this.text,
    required this.onPressed,
    this.isDisabled = false,
    this.isOutline = false,
    this.isLoading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isDisabled ? null : () => onPressed(),
      style: Theme.of(context).elevatedButtonTheme.style?.copyWith(
        backgroundColor: MaterialStateProperty.all<Color>(
          isOutline
            ? Theme.of(context).colorScheme.primary
            : Theme.of(context).colorScheme.secondary,
        ),
      ),
      child: isLoading
        ? SizedBox(
            height: 20,
            width: 20,
            child: CircularProgressIndicator(
              color: Theme.of(context).textTheme.labelSmall?.backgroundColor,
              strokeWidth: 2,
            ),
          )
        : Text(
            text,
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
              color: isOutline
                ? Theme.of(context).colorScheme.secondary
                : Theme.of(context).colorScheme.primary,
              backgroundColor: Colors.transparent,
            ),
          ),
    );
  }
}