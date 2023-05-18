import 'package:flutter/material.dart';

class AntiBug extends StatelessWidget {
  const AntiBug({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AntiBug'),
      ),
      body: const Center(
        child: Text(
          'AntiBug Screen',
          style: TextStyle(fontSize: 40),
        ),
      ),
    );
  }
}
