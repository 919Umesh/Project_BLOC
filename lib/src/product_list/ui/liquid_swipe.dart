import 'package:flutter/material.dart';
import 'package:liquid_swipe/liquid_swipe.dart';

class LiquidSwipeExample extends StatelessWidget {
   LiquidSwipeExample({super.key});

  final pages = [
    Container(
      color: Colors.red,
      child: const Center(
        child: Text(
          'Page 1',
          style: TextStyle(fontSize: 32, color: Colors.white),
        ),
      ),
    ),
    Container(
      color: Colors.green,
      child: const Center(
        child: Text(
          'Page 2',
          style: TextStyle(fontSize: 32, color: Colors.white),
        ),
      ),
    ),
    Container(
      color: Colors.blue,
      child: const Center(
        child: Text(
          'Page 3',
          style: TextStyle(fontSize: 32, color: Colors.white),
        ),
      ),
    ),
    Container(
      color: Colors.orange,
      child: const Center(
        child: Text(
          'Page 4',
          style: TextStyle(fontSize: 32, color: Colors.white),
        ),
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LiquidSwipe(
        pages: pages,
        enableLoop: true,
        fullTransitionValue: 300,
        waveType: WaveType.liquidReveal,
        positionSlideIcon: 0.5,
        slideIconWidget: const Icon(Icons.arrow_back_ios, color: Colors.white),
        onPageChangeCallback: (index) {
          debugPrint('Current Page: $index');
        },
      ),
    );
  }
}