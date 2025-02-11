import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';

//ConfettiScreen
class ConfettiScreen extends StatefulWidget {
  const ConfettiScreen({super.key});

  @override
  State<ConfettiScreen> createState() => _ConfettiScreenState();
}

class _ConfettiScreenState extends State<ConfettiScreen> {
  late ConfettiController _controller;

  @override
  void initState() {
    super.initState();
    _controller = ConfettiController(duration: const Duration(seconds: 6));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }


  void _startConfetti() {
    _controller.play();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Confetti Animation'),
      ),
      body: Stack(
        children: [
          // Centered content
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Press the button to celebrate!',
                  style: TextStyle(fontSize: 20),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _startConfetti, // Trigger confetti
                  child: const Text('Celebrate!'),
                ),
              ],
            ),
          ),

          // Confetti Widget
          Align(
            alignment: Alignment.topCenter,
            child: ConfettiWidget(
              confettiController: _controller,
              blastDirectionality: BlastDirectionality.explosive,
              shouldLoop: false,
              colors: const [
                Colors.red,
                Colors.green,
                Colors.pink,
                Colors.purple,
              ],
              numberOfParticles: 30,
              gravity: 0.1,
              emissionFrequency: 0.02,
              minBlastForce: 5,
              maxBlastForce: 20,
            ),
          ),
        ],
      ),
    );
  }
}