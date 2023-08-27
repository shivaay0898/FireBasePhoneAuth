import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

late List<CameraDescription> cameras;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  runApp(const MyCamera());
}

class MyCamera extends StatefulWidget {
  const MyCamera({super.key});

  @override
  State<MyCamera> createState() => _MyCameraState();
}

class _MyCameraState extends State<MyCamera> {
  late CameraController _controller;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = CameraController(cameras[0], ResolutionPreset.max);
    _controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    }).catchError((Object e) {
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessDenied':
            print('Access was denied');
            break;
          default:
            print(e.description);
            break;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            child: CameraPreview(_controller),
          ),
          Positioned(
            bottom: 0,
            left: MediaQuery.of(context).size.width/2,
            child: RawMaterialButton(
              onPressed: () {},
              child: Text("Take a video"),
            ),
          )
        ],
      ),
    );
  }
}
