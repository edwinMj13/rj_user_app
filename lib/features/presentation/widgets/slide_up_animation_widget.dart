import 'package:flutter/material.dart';

class SlideUPAnimatedWidget extends StatelessWidget {
  final Widget childWidget;
  final AnimationController animationController;

  const SlideUPAnimatedWidget(
      {super.key,
        required this.childWidget,
        required this.animationController});

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(0,1),
        end: Offset.zero,
      ).animate(animationController),
      child: FadeTransition(
        opacity: animationController,
        child: childWidget,
      ),
    );
  }
}
