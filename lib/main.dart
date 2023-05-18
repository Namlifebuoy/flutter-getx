import 'package:firstgetx/shared/store/home.dart';
import 'package:firstgetx/widgets/navigation/tab_navigator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main(List<String> args) {
  Get.put(HomeStore());

  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: TabNavigator(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hello Navigator'),
      ),
      body: Container(),
    );
  }
}
