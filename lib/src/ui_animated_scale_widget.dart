import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'animated_scale_cubit.dart';

class UIAnimatedScaleWidget extends StatefulWidget {
  final Widget child;
  final Function(AnimatedScaleCubit, TapDownDetails)? onTapDown;
  final Function(AnimatedScaleCubit, TapUpDetails)? onTapUp;

  const UIAnimatedScaleWidget({
    super.key,
    required this.child,
    this.onTapDown,
    this.onTapUp,
  });

  @override
  State<UIAnimatedScaleWidget> createState() => _UIAnimatedScaleWidgetState();
}

class _UIAnimatedScaleWidgetState extends State<UIAnimatedScaleWidget>
    with SingleTickerProviderStateMixin {
  late final AnimatedScaleCubit _animatedScaleCubit;

  @override
  void initState() {
    super.initState();
    _animatedScaleCubit = AnimatedScaleCubit(
      vsync: this,
      widget: widget.child,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: _animatedScaleCubit,
      builder: (context, state) {
        return GestureDetector(
          onTapDown: (details) {
            if (widget.onTapDown == null) _animatedScaleCubit.compress();
            widget.onTapDown?.call(_animatedScaleCubit, details);
          },
          onTapUp: (TapUpDetails details) {
            if (widget.onTapDown == null) _animatedScaleCubit.expand();
            widget.onTapUp?.call(_animatedScaleCubit, details);
          },
          child: _animatedScaleCubit.child,
        );
      },
    );
  }
}
