import 'package:camera/camera.dart';
import 'package:firstgetx/shared/store/favorite.dart';
import 'package:firstgetx/shared/store/home.dart';
import 'package:firstgetx/widgets/navigation/tab_navigator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main(List<String> args) async {
  Get.put(HomeStore());
  Get.put(FavoriteStore());

  List<CameraDescription> cameras;
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();

  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    home: TabNavigator(cameras: cameras),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // double width = MediaQuery.of(context).size.width;
    // double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hello Navigator'),
      ),
      body: Container(),
    );
  }
}
