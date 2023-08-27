import 'package:camera/camera.dart';
import 'package:demoblackcoffer/home.dart';
import 'package:demoblackcoffer/otp.dart';
import 'package:demoblackcoffer/phone.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'firebase_options.dart';


Future <void> main() async{
WidgetsFlutterBinding.ensureInitialized();
cameras =await availableCameras();
await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,);
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: 'phone',
    routes: {
      'home':(context)=>MyCamera(),
      'phone':(context)=>MyPhone(),
      'otp':(context)=>MyOtp(),
    },
  ));
}
