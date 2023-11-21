import 'package:flutter/material.dart';

class AnimatedOpacityTextButton extends StatefulWidget {
  final VoidCallback onTap;
  final Widget child;

  const AnimatedOpacityTextButton({
    Key? key,
    required this.onTap,
    required this.child,
  }) : super(key: key);

  @override
  State<AnimatedOpacityTextButton> createState() => _AnimatedOpacityTextButtonState();
}

class _AnimatedOpacityTextButtonState extends State<AnimatedOpacityTextButton> {
  double _opacity = 1.0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        setState(() {
          _opacity = 0.5;
        });
        widget.onTap();
      },
      onTapUp: (_) {
        setState(() {
          _opacity = 1.0;
        });
      },
      child: Material(
        color: Colors.transparent,
        child: Opacity(
          opacity: _opacity,
          child: widget.child,
        ),
      ),
    );
  }
}
