import 'package:flutter/material.dart';

class Detect extends StatelessWidget {
  const Detect({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detect'),
      ),
      body: const Center(
        child: Text(
          'Detect Screen',
          style: TextStyle(fontSize: 40),
        ),
      ),
    );
  }
}
