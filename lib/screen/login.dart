import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:namebuzz/api/api_service.dart';
import 'package:namebuzz/const/const.dart';
import 'package:namebuzz/screen/home.dart';
import 'package:namebuzz/screen/otp_screen.dart';
import 'package:namebuzz/screen/signup.dart';
import 'package:namebuzz/const/widget/custom_button.dart';
import 'package:pinput/pinput.dart';
import '../const/widget/custom_alert.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool showUserTextField = true;
  bool showPhoneTextField = true;
  bool showPasswordTextField = false;
  TextEditingController userNameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    //OTP code start
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: TextStyle(
          fontSize: 20,
          color: Color.fromRGBO(30, 60, 87, 1),
          fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        border: Border.all(color: Color.fromRGBO(234, 239, 243, 1)),
        borderRadius: BorderRadius.circular(20),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: Color.fromRGBO(114, 178, 238, 1)),
      borderRadius: BorderRadius.circular(8),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        color: Color.fromRGBO(234, 239, 243, 1),
      ),
    );
// OTP code end
    return Scaffold(
        backgroundColor: themeColor.withOpacity(0.8),
        body: Stack(
          children: [
            Positioned.fill(
              child: Align(
                alignment: Alignment.center,
                child: SingleChildScrollView(
                  child: Container(
                    height: 380.h,
                    width: 318.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(28)),
                      color: Colors.white,
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 50.h,
                        ),
                        Text(
                          'Login and Buzz Your Name',
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 16.h,
                        ),

                        Visibility(
                          visible: showUserTextField,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20, right: 20),
                            child: TextField(
                              onChanged: (value) {
                                if (userNameController.text.isNotEmpty) {
                                  setState(() {
                                    showPhoneTextField = false;
                                    showPasswordTextField = true;
                                  });
                                } else {
                                  setState(() {
                                    showPhoneTextField = true;
                                    showPasswordTextField = false;
                                  });
                                }
                              },
                              controller: userNameController,
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.person),
                                hintText: 'Email / Username',
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.black),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        //PhoneNumber InputField
                        Visibility(
                          visible: showPasswordTextField,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20, right: 20),
                            child: TextField(
                              controller: passwordController,
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.lock),
                                hintText: 'Password',
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.black),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                              ),
                            ),
                          ),
                        ),
                        userNameController.text.isNotEmpty ||
                                phoneNumberController.text.isNotEmpty
                            ? SizedBox.shrink()
                            : SizedBox(
                                height: 10,
                              ),
                        userNameController.text.isNotEmpty ||
                                phoneNumberController.text.isNotEmpty
                            ? SizedBox.shrink()
                            : Text(
                                '-------------------- OR --------------------',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                        userNameController.text.isNotEmpty ||
                                phoneNumberController.text.isNotEmpty
                            ? SizedBox.shrink()
                            : SizedBox(
                                height: 10,
                              ),
                        Visibility(
                          visible: showPhoneTextField,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20, right: 20),
                            child: TextField(
                              maxLength: 10,
                              keyboardType: TextInputType.phone,
                              onChanged: (value) {
                                log('value $value');
                                if (phoneNumberController.text.isNotEmpty) {
                                  setState(() {
                                    showUserTextField = false;
                                  });
                                } else {
                                  setState(() {
                                    showUserTextField = true;
                                  });
                                }
                              },
                              controller: phoneNumberController,
                              decoration: InputDecoration(
                                counterText: '',
                                prefixIcon: Icon(Icons.phone),
                                hintText: 'Phone Number',
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.black),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                              ),
                            ),
                          ),
                        ),

                        SizedBox(
                          height: 18.h,
                        ),
                        //Send OTP Button
                        userNameController.text.isEmpty &&
                                phoneNumberController.text.isEmpty
                            ? SizedBox.shrink()
                            : Padding(
                                padding: EdgeInsets.only(left: 20, right: 20),
                                child: InkWell(
                                  child: Container(
                                    height: 44.h,
                                    width: 310.w,
                                    decoration: BoxDecoration(
                                        color: themeColor.withOpacity(0.95),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
                                    child: Center(
                                      child: Text(
                                        'Continue',
                                        style: TextStyle(
                                            fontSize: 19,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                    ),
                                  ),
                                  onTap: () async {
                                    if (phoneNumberController.text.isEmpty) {
                                      if (passwordController.text.isEmpty) {
                                        showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              Future.delayed(
                                                  const Duration(
                                                      milliseconds: 800), () {
                                                Navigator.of(context).pop(true);
                                              });
                                              return const CustomAlert(
                                                alertTitle:
                                                    'Please Enter Password',
                                              );
                                            });
                                      } else if (userNameController
                                          .text.isNotEmpty) {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    HomeScreen()));
                                      }
                                    } else {
                                      if (phoneNumberController.length < 10) {
                                        showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              Future.delayed(
                                                  const Duration(
                                                      milliseconds: 800), () {
                                                Navigator.of(context).pop(true);
                                              });
                                              return const CustomAlert(
                                                alertTitle:
                                                    'Please Enter Valid Phone Number',
                                              );
                                            });
                                      } else {
                                        dynamic response = await ApiService()
                                            .sendOtp(
                                                phoneNumberController.text);
                                        // .sendOtp(
                                        //     phoneNumberController.text);
                                        log('message $response');
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => OtpScreen(
                                                    register: false)));
                                      }
                                    }
                                  },
                                ),
                              ),
                        SizedBox(
                          height: 10,
                        ),
                        // Signup with google container
                        userNameController.text.isNotEmpty ||
                                phoneNumberController.text.isNotEmpty
                            ? SizedBox.shrink()
                            : Padding(
                                padding:
                                    const EdgeInsets.only(left: 24, right: 24),
                                child: InkWell(
                                  child: Container(
                                    color: Colors.blueAccent,
                                    child: Row(
                                      children: [
                                        Container(
                                          height: 40.h,
                                          width: 40.w,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                                image: AssetImage(
                                                    'assets/buzz-logo.png'),
                                                fit: BoxFit.cover),
                                          ),
                                          // child: Image.asset('assets/buzz-logo.png'),
                                        ),
                                        SizedBox(
                                          width: 14.w,
                                        ),
                                        Text(
                                          'Sign in with google',
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                        )
                                      ],
                                    ),
                                  ),
                                  onTap: () {},
                                ),
                              ),

                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Don't have an account?"),
                              TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) => SignupScreen()));
                                  },
                                  child: Text('Register here'))
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Positioned.fill(
              bottom: 380.h,
              child: Align(
                alignment: Alignment.center,
                child: Container(
                    height: 100.h, child: Image.asset('assets/buzz-logo.png')),
              ),
            ),
          ],
        ));
  }
}
