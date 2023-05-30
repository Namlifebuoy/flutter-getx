import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class Detect extends StatefulWidget {
  Detect({super.key, required this.cameras});

  List<CameraDescription> cameras;
  @override
  State<Detect> createState() => _DetectState();
}

class _DetectState extends State<Detect> {
  late CameraController controller;

  // @override
  // void initState() {
  //   super.initState();
  //   controller = CameraController(widget.cameras[0], ResolutionPreset.max);
  //   controller.initialize().then((_) {
  //     if (!mounted) {
  //       return;
  //     }
  //     setState(() {});
  //   }).catchError((Object e) {
  //     if (e is CameraException) {
  //       switch (e.code) {
  //         case 'CameraAccessDenied':
  //           // Handle access errors here.
  //           break;
  //         default:
  //           // Handle other errors here.
  //           break;
  //       }
  //     }
  //   });
  // }

  // @override
  // void dispose() {
  //   controller.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detect'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var status = await Permission.camera.status;
          print("hello: $status");
          if (status.isGranted) {
            print("Camera granted");
          } else if (status.isDenied) {
            print("Camera denied");
            await Permission.camera.request();
            // _requireCamera(context);
          } else if (await Permission.camera.isPermanentlyDenied) {
            openAppSettings();
          }
        },
      ),
      body: const Center(
        child: Text(
          'Detect Screen',
          style: TextStyle(fontSize: 40),
        ),
      ),
    );
    // return MaterialApp(
    //   home: CameraPreview(controller),
    // );
  }
}

// _requireCamera(context) async {
//   var camera = await Permission
// }
