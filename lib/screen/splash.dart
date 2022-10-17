import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:namebuzz/const/const.dart';
import 'package:namebuzz/screen/login.dart';
import 'package:namebuzz/screen/signup.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    //  SplashScreen to Login/Home Screen showing time
    Timer(
        const Duration(seconds: 4),
        () => Navigator.push(
            context, MaterialPageRoute(builder: (_) => const LoginScreen())));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: postBuzzColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(12)),
              ),
              child: Padding(
                padding: EdgeInsets.all(6.0),
                child: Column(
                  children: [
                    Container(
                      width: 114,
                      child: Image.asset('assets/buzz-logo.png'),
                    ),
                    Text(
                      'Namebuzz',
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    Text(
                      'Buzz your name',
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0XFFEC7063),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 100.h,
            ),
            Text(
              'Made in India',
              style: TextStyle(
                  fontSize: 26,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
