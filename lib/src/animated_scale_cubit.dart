import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

part 'animated_transform.dart';

enum AnimatedScaleState {
  compress,
  normal,
  expand,
}

class AnimatedScaleCubit extends Cubit<AnimatedScaleState> {
  late final AnimationController _controller;
  late final AnimatedTransform _animatedButton;
  final Duration duration;
  final double upperBoundTransform;

  Widget get child => _animatedButton;

  AnimatedScaleCubit({
    required TickerProvider vsync,
    required Widget widget,
    this.duration = const Duration(milliseconds: 200),
    this.upperBoundTransform = 0.1,
  })  : assert(
          upperBoundTransform > 0.0 && upperBoundTransform <= 1.0,
          'upperBoundTransform must be between 0.0 and 1.0',
        ),
        super(AnimatedScaleState.normal) {
    _controller = _defaultController(vsync);
    _animatedButton = AnimatedTransform(
      controller: _controller,
      animatingWidget: widget,
    );
  }

  @override
  Future<void> close() {
    _controller.dispose();
    return super.close();
  }

  void compress() {
    if (state != AnimatedScaleState.normal) return;
    _controller.forward();
    emit(AnimatedScaleState.compress);
  }

  void expand() {
    if (state != AnimatedScaleState.compress) return;
    _controller.reverse();
    emit(AnimatedScaleState.normal);
  }

  void normal() {
    if (state == AnimatedScaleState.normal) return;
    _controller.reset();
    emit(AnimatedScaleState.normal);
  }

  AnimationController _defaultController(TickerProvider vsync) =>
      AnimationController(
        vsync: vsync,
        duration: duration,
        lowerBound: 0.0,
        upperBound: upperBoundTransform,
      );
}
