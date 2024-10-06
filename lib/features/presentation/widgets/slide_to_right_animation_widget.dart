import 'package:flutter/material.dart';

class SlideToRightAnimationWidget extends StatelessWidget {
  final Widget childWidget;
  final AnimationController animationController;

  const SlideToRightAnimationWidget(
      {super.key,
      required this.childWidget,
      required this.animationController});

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(-2, 0),
        end: Offset.zero,
      ).animate(animationController),
      child: FadeTransition(
        opacity: animationController,
        child: childWidget,
      ),
    );
  }
}
