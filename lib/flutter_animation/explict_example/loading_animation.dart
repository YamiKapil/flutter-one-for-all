import 'package:flutter/material.dart';

class LoadingAnimation extends StatefulWidget {
  final double progress;
  final Color color;
  const LoadingAnimation({
    super.key,
    required this.progress,
    required this.color,
  });

  @override
  State<LoadingAnimation> createState() => _LoadingAnimationState();
}

class _LoadingAnimationState extends State<LoadingAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;
  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 950),
    );
    animation =
        Tween<double>(begin: 0, end: widget.progress).animate(controller);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimatedBuilder(
          animation: animation,
          builder: (context, child) {
            return Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 150,
                  height: 150,
                  child: CircularProgressIndicator(
                    value: animation.value / 100,
                    strokeWidth: 10,
                    backgroundColor: Colors.grey.shade100,
                    color: widget.color,
                  ),
                ),
                Text(
                  "${animation.value.toInt().toString()} %",
                ),
              ],
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (animation.isCompleted) {
            controller.reverse();
          } else {
            controller.forward();
          }
        },
        child: const Icon(Icons.forward),
      ),
    );
  }
}
