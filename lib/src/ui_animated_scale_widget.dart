import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_haptics_flutter/ui_haptics_flutter.dart';
import 'animated_scale_cubit.dart';

class UIAnimatedScaleWidget extends StatefulWidget {
  final double upperBoundTransform;
  final Duration animationDuration;
  final Function(AnimatedScaleCubit, TapDownDetails)? onTapDown;
  final Function(AnimatedScaleCubit, TapUpDetails)? onTapUp;
  final HapticFeedbackEnum hapticFeedback;
  final Widget child;

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
