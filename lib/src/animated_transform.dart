import 'package:flutter/material.dart';

class AnimatedTransform extends AnimatedWidget {
  final AnimationController controller;
  final Widget animatingWidget;
  const AnimatedTransform({
    super.key,
    required this.controller,
    required this.animatingWidget,
  }) : super(listenable: controller);

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: 1.0 - controller.value,
      child: animatingWidget,
    );
  }
}
