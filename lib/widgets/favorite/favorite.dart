import 'package:flutter/material.dart';

class Favorite extends StatelessWidget {
  const Favorite({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite'),
      ),
      body: const Center(
        child: Column(
          children: [
            Text(
              'Favorite Screen',
              style: TextStyle(fontSize: 40),
            ),
            InkWell(
              child: Image(
                image: AssetImage('assets/images/ic_detect.png'),
                width: 100,
                height: 100,
                fit: BoxFit.fitWidth,
              ),
            )
          ],
        ),
      ),
    );
  }
}
