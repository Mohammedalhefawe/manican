import 'package:manicann/core/theme/app_colors.dart';

import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SizedBox(child: RectangleLoadingAnimation()),
    );
  }
}

class RectangleLoadingAnimation extends StatefulWidget {
  const RectangleLoadingAnimation({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _RectangleLoadingAnimationState createState() =>
      _RectangleLoadingAnimationState();
}

class _RectangleLoadingAnimationState extends State<RectangleLoadingAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 700),
      vsync: this,
    )..repeat();
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(15, (index) {
              double interval = index / 10;
              Color color =
                  _animation.value > interval ? Colors.amber : lightGrey;
              return Container(
                margin: const EdgeInsets.all(2.0),
                width: 8,
                height: 12,
                color: color,
              );
            }),
          );
        },
      ),
    );
  }
}
