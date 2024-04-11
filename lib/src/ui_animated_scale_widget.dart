import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_haptics_flutter/ui_haptics_flutter.dart';

import '../ui_animated_scale_flutter.dart';

/// A widget that animates its child's scale on tap, with optional haptic feedback.
///
/// This widget wraps its child with an animation that scales the child's size when tapped.
/// It also supports providing haptic feedback on tap events.
///
/// By default, it scales down the child when tapped down and scales it back to its original size when tapped up.
/// However, this behavior can be overridden by providing custom onTapDown and onTapUp callbacks.
///
/// The animation's parameters like duration and upper bound transform can be customized as well.
///
/// Example usage:
/// ```dart
/// UIAnimatedScaleWidget(
///   animationDuration: Duration(milliseconds: 300),
///   hapticFeedback: HapticFeedbackEnum.medium,
///   onTapDown: (cubit, details) {
///     // Custom logic on tap down event
///   },
///   onTapUp: (cubit, details) {
///     // Custom logic on tap up event
///   },
///   child: Container(
///     width: 100,
///     height: 100,
///     color: Colors.blue,
///     child: Center(
///       child: Text(
///         'Tap Me!',
///         style: TextStyle(
///           color: Colors.white,
///           fontSize: 20,
///         ),
///       ),
///     ),
///   ),
/// )
/// ```
class UIAnimatedScaleWidget extends StatefulWidget {
  /// The upper bound for the scale transform during animation.
  ///
  /// Defaults to 0.1, which means the child's size will be scaled down to 10% of its original size.
  final double upperBoundTransform;

  /// The duration of the scale animation.
  ///
  /// Defaults to 200 milliseconds.
  final Duration animationDuration;

  /// Callback for tap down event.
  ///
  /// This function will be called when a tap down event is detected.
  /// It passes the [AnimatedScaleCubit] and [TapDownDetails] as arguments.
  /// If not provided, the default behavior is to compress the child.
  final Function(AnimatedScaleCubit, TapDownDetails)? onTapDown;

  /// Callback for tap up event.
  ///
  /// This function will be called when a tap up event is detected.
  /// It passes the [AnimatedScaleCubit] and [TapUpDetails] as arguments.
  /// If not provided, the default behavior is to expand the child.
  final Function(AnimatedScaleCubit, TapUpDetails)? onTapUp;

  /// The type of haptic feedback to provide on tap events.
  ///
  /// Defaults to [HapticFeedbackEnum.none], indicating no haptic feedback.
  final HapticFeedbackEnum hapticFeedback;

  /// The widget to be animated.
  final Widget child;

  /// Constructs a [UIAnimatedScaleWidget] instance.
  ///
  /// The [child] parameter must not be null.
  const UIAnimatedScaleWidget({
    super.key,
    this.animationDuration = const Duration(milliseconds: 200),
    this.hapticFeedback = HapticFeedbackEnum.none,
    this.onTapDown,
    this.onTapUp,
    this.upperBoundTransform = 0.1,
    required this.child,
  });

  @override
  State<UIAnimatedScaleWidget> createState() => _UIAnimatedScaleWidgetState();
}

class _UIAnimatedScaleWidgetState extends State<UIAnimatedScaleWidget>
    with SingleTickerProviderStateMixin {
  late final AnimatedScaleCubit animatedScaleCubit;

  @override
  void initState() {
    super.initState();
    animatedScaleCubit = AnimatedScaleCubit(
      vsync: this,
      widget: widget.child,
      duration: widget.animationDuration,
      upperBoundTransform: widget.upperBoundTransform,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: animatedScaleCubit,
      builder: (context, state) {
        return GestureDetector(
          onTapDown: (TapDownDetails details) async {
            await widget.hapticFeedback.haptic;
            if (widget.onTapDown == null) animatedScaleCubit.compress();
            widget.onTapDown?.call(animatedScaleCubit, details);
          },
          onTapUp: (TapUpDetails details) {
            if (widget.onTapDown == null) animatedScaleCubit.expand();
            widget.onTapUp?.call(animatedScaleCubit, details);
          },
          child: animatedScaleCubit.child,
        );
      },
    );
  }
}
