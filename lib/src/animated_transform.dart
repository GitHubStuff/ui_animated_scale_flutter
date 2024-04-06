part of 'animated_scale_cubit.dart';

/// This class defines an AnimatedTransform widget, which is used to animate the scaling of another widget.
///
/// It extends [AnimatedWidget] to automatically rebuild when the [AnimationController] notifies its listeners.
class AnimatedTransform extends AnimatedWidget {
  /// The animation controller responsible for driving the animation.
  final AnimationController controller;

  /// The widget to be animated.
  final Widget animatingWidget;

  /// Constructs an [AnimatedTransform] widget.
  ///
  /// The [controller] and [animatingWidget] parameters are required.
  const AnimatedTransform({
    super.key,
    required this.controller,
    required this.animatingWidget,
  }) : super(listenable: controller);

  @override
  Widget build(BuildContext context) {
    // Returns a Transform widget with scaling animation applied to the child widget.
    return Transform.scale(
      scale: 1.0 - controller.value,
      child: animatingWidget,
    );
  }
}
