
import 'package:flutter/material.dart';

class TweenAnimationExample extends StatefulWidget {
  const TweenAnimationExample({super.key});

  @override
  State<TweenAnimationExample> createState() => _TweenAnimationExampleState();
}

class _TweenAnimationExampleState extends State<TweenAnimationExample>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    // Step 1: Create an AnimationController
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    // Step 2: Define a Tween to interpolate between 50.0 and 200.0
    _animation = Tween<double>(begin: 50.0, end: 200.0).animate(_controller)
      ..addListener(() {
        setState(() {}); // Rebuild the widget when the animation value changes
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _controller.reverse(); // Reverse the animation when it completes
        } else if (status == AnimationStatus.dismissed) {
          _controller.forward(); // Restart the animation when it finishes reversing
        }
      });

    // Step 3: Start the animation
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose(); // Dispose the controller to free resources
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tween Animation Example'),
      ),
      body: Center(
        child: Container(
          width: _animation.value, // Use the animated value for the width
          height: _animation.value, // Use the animated value for the height
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
    );
  }
}