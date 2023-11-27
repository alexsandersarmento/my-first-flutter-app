import 'package:flutter/material.dart';

class CustomNavigationDestination extends StatefulWidget {
  final Widget icon;
  final String label;
  final Color color;
  final Color activeColor;

  const CustomNavigationDestination({
    Key? key,
    required this.icon,
    required this.label,
    required this.color,
    required this.activeColor,
  }) : super(key: key);

  @override
  State<CustomNavigationDestination> createState() => _CustomNavigationDestinationState();
}

class _CustomNavigationDestinationState extends State<CustomNavigationDestination> with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          widget.icon,
          Text(
            widget.label,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: widget.color,
            ),
          ),
        ],
      ),
    );
  }
}
