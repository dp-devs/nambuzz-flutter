import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:namebuzz/screen/home.dart';
import 'package:namebuzz/screen/login.dart';
import 'package:namebuzz/screen/signup.dart';
import 'package:namebuzz/screen/signupfrom.dart';
import 'package:namebuzz/screen/splash.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, state) {
        return const MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Namebuzz',
            home: HomeScreen());
      },
    );
  }
}
