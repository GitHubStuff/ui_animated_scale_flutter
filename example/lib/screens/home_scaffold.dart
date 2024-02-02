// ignore_for_file: sort_child_properties_last

import 'package:flutter/material.dart';

import '../gen/assets.gen.dart';

import 'package:ui_animated_scale_flutter/ui_animated_scale_flutter.dart';

class HomeScaffold extends StatelessWidget {
  const HomeScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: homeWidget(context),
      floatingActionButton: null,
    );
  }

  Widget homeWidget(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          UIAnimatedScaleWidget(
            child: SizedBox(
              width: 200,
              height: 200,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Assets.images.ltmm1024x1024.image(),
              ),
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Tap on the image to see the animation.',
            style: TextStyle(fontSize: 20),
          ),
          const SizedBox(height: 20),
          UIAnimatedScaleWidget(
            onTapDown: (cubit, details) {
              if (cubit.state == AnimatedScaleState.normal) {
                cubit.compress();
              } else {
                cubit.expand();
              }
            },
            onTapUp: null,
            child: const Text(
              'Tap Me for State!',
              style: TextStyle(fontSize: 20),
            ),
          )
        ],
      ),
    );
  }
}
