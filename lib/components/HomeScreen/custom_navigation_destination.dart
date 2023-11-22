import 'package:flutter/material.dart';

class CustomNavigationDestination extends StatefulWidget {
  final Widget icon;
  final Widget label;
  final Color color;
  final Color activeColor;
  final bool selected;
  final double size;
  final VoidCallback onTap;

  const CustomNavigationDestination({
    Key? key,
    required this.icon,
    required this.label,
    required this.color,
    required this.activeColor,
    required this.selected,
    required this.onTap,
    this.size = 56
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
      height: widget.size,
      child: InkWell(
        onTap: () {
          widget.onTap();
        },
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            IconTheme.merge(
              data: IconThemeData(
                color: widget.selected ? widget.activeColor : widget.color,
              ),
              child: widget.icon,
            ),
            DefaultTextStyle.merge(
              style: TextStyle(
                color: widget.selected ? widget.activeColor : widget.color,
              ),
              child: widget.label,
            ),
          ],
        ),
      ),
    );
  }
}
