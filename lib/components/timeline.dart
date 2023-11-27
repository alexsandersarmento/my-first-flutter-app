import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:visibility_detector/visibility_detector.dart';

class Timeline extends StatefulWidget {
  const Timeline({Key? key}) : super(key: key);

  @override
  State<Timeline> createState() => _TimelineState();
}

class _TimelineState extends State<Timeline> {
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {

    return ListView.builder(
      itemCount: 100,
      controller: _scrollController,
      padding: const EdgeInsets.symmetric(vertical: 40),
      itemBuilder: (context, i) {
        return TimelineTile(
          index: i,
          scrollController: _scrollController,
        );
      }
    );
  }
}

class TimelineTile extends StatelessWidget {
  final int index;
  final ScrollController scrollController;

  const TimelineTile({Key? key, required this.index, required this.scrollController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _AnimatedLeftChild(index: index, controller: scrollController),
        const SizedBox(width: 20),
        _Indicator(index: index),
        const SizedBox(width: 20),
        _AnimatedRightChild(index: index, controller: scrollController)
      ],
    );
  }
}

class _AnimatedLeftChild extends StatefulWidget {
  final int index;
  final ScrollController controller;

  const _AnimatedLeftChild({Key? key, required this.index, required this.controller}) : super(key: key);

  @override
  State<_AnimatedLeftChild> createState() => _AnimatedLeftChildState();
}

class _AnimatedLeftChildState extends State<_AnimatedLeftChild> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    double begin = widget.controller.position.userScrollDirection ==  ScrollDirection.forward  ? 0 : -100;
    double opacityBegin = widget.controller.position.userScrollDirection ==  ScrollDirection.forward  ? 1 : 0;

    _animation = Tween<double>(begin: begin, end: 0).animate(_animationController);
    _opacityAnimation = Tween<double>(begin: opacityBegin, end: 1).animate(_animationController);
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.index % 2 == 0
      ? VisibilityDetector(
          key: Key(widget.index.toString()),
          onVisibilityChanged: (visibilityInfo) {
            if (visibilityInfo.visibleFraction == 1) {
              _animationController.forward();
            }
          },
          child: AnimatedBuilder(
            animation: _animationController,
            builder:  (context, child) {
              return Opacity(
                opacity: _opacityAnimation.value,
                child: Transform.translate(
                  offset: Offset(_animation.value, 0),
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: const BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                  ),
                ),
              );
            },
          ),
      )
      : Container(
          width: 100,
          height: 100,
          color: Colors.transparent,
        );
  }
}

class _AnimatedRightChild extends StatefulWidget {
  final int index;
  final ScrollController controller;

  const _AnimatedRightChild({Key? key, required this.index, required this.controller}) : super(key: key);

  @override
  State<_AnimatedRightChild> createState() => _AnimatedRightChildState();
}

class _AnimatedRightChildState extends State<_AnimatedRightChild> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    double begin = widget.controller.position.userScrollDirection ==  ScrollDirection.forward  ? 0 : 100;
    double opacityBegin = widget.controller.position.userScrollDirection ==  ScrollDirection.forward  ? 1 : 0;

    _animation = Tween<double>(begin: begin, end: 0).animate(_animationController);
    _opacityAnimation = Tween<double>(begin: opacityBegin, end: 1).animate(_animationController);
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.index % 2 == 1
      ? VisibilityDetector(
          key: Key(widget.index.toString()),
          onVisibilityChanged: (visibilityInfo) {
            if (visibilityInfo.visibleFraction == 1) {
              _animationController.forward();
            }
          },
          child: AnimatedBuilder(
            animation: _animationController,
            builder:  (context, child) {
              return Opacity(
                opacity: _opacityAnimation.value,
                child: Transform.translate(
                  offset: Offset(_animation.value, 0),
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: const BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                  ),
                ),
              );
            },
          ),
      )
      : Container(
          width: 100,
          height: 100,
          color: Colors.transparent,
        );
  }
}

class _Indicator extends StatelessWidget {
  final int index;

  const _Indicator({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        index == 0
            ? Container(width: 2, height: 50, color: Colors.transparent)
            : Container(width: 2, height: 50, color: Colors.black),
        Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            color:  Colors.black,
            shape: BoxShape.circle,
            border: Border.all(color: Colors.black, width: 2)
          ),
        ),
        index == 99
            ? Container(width: 2, height: 50, color: Colors.transparent)
            : Container(width: 2, height: 50, color: Colors.black),
      ],
    );
  }
}
