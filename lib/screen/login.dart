import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:namebuzz/api/api_service.dart';
import 'package:namebuzz/const/const.dart';
import 'package:namebuzz/screen/home.dart';
import 'package:namebuzz/screen/otp_screen.dart';
import 'package:namebuzz/screen/signup.dart';
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
  var db = Hive.box('profileDetails');
  bool buttonIsClicked = false;

  @override
  Widget build(BuildContext context) {
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
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(28)),
                      color: Colors.white,
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 50.h,
                        ),
                        const Text(
                          'Login and Buzz Your Name',
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 16.h,
                        ),

                        ////////////////////////////
                        // UserName InputField //
                        ////////////////////////////

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
                              decoration: const InputDecoration(
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

                        ////////////////////////////
                        // PhoneNumber InputField //
                        ////////////////////////////

                        Visibility(
                          visible: showPasswordTextField,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20, right: 20),
                            child: TextField(
                              controller: passwordController,
                              decoration: const InputDecoration(
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
                            ? const SizedBox.shrink()
                            : const SizedBox(
                                height: 10,
                              ),
                        userNameController.text.isNotEmpty ||
                                phoneNumberController.text.isNotEmpty
                            ? const SizedBox.shrink()
                            : const Text(
                                '-------------------- OR --------------------',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                        userNameController.text.isNotEmpty ||
                                phoneNumberController.text.isNotEmpty
                            ? const SizedBox.shrink()
                            : const SizedBox(
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
                              decoration: const InputDecoration(
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

                        //////////////////////
                        // Send OTP button //
                        ////////////////////

                        userNameController.text.isEmpty &&
                                phoneNumberController.text.isEmpty
                            ? const SizedBox.shrink()
                            : Padding(
                                padding:
                                    const EdgeInsets.only(left: 20, right: 20),
                                child: InkWell(
                                  child: Container(
                                    height: 44.h,
                                    width: 310.w,
                                    decoration: BoxDecoration(
                                        color: themeColor.withOpacity(0.95),
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(10))),
                                    child: Center(
                                      child: buttonIsClicked
                                          ? CircularProgressIndicator(
                                              color: Colors.white,
                                            )
                                          : Text(
                                              'Continue',
                                              style: TextStyle(
                                                  fontSize: 19,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white),
                                            ),
                                    ),
                                  ),
                                  onTap: () async {
                                    setState(() {
                                      buttonIsClicked = true;
                                    });
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
                                        setState(() {
                                          buttonIsClicked = false;
                                        });
                                      } else if (userNameController
                                          .text.isNotEmpty) {
                                        dynamic response = await ApiService()
                                            .loginUser(userNameController.text,
                                                passwordController.text);
                                        log('logged in user == $response');
                                        if (response != 'User Found') {
                                          showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                Future.delayed(
                                                    const Duration(
                                                        milliseconds: 800), () {
                                                  Navigator.of(context)
                                                      .pop(true);
                                                });
                                                return const CustomAlert(
                                                  alertTitle:
                                                      'Wrong Credentials',
                                                );
                                              });
                                          setState(() {
                                            buttonIsClicked = false;
                                          });
                                        } else {
                                          setState(() {
                                            buttonIsClicked = false;
                                          });
                                          // ignore: use_build_context_synchronously
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const HomeScreen()));
                                        }
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
                                        setState(() {
                                          buttonIsClicked = false;
                                        });
                                      } else {
                                        dynamic response = await ApiService()
                                            .checkPhone(
                                                phoneNumberController.text);
                                        log('response check phone == $response');
                                        if (response !=
                                            'User with same number exists') {
                                          showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                Future.delayed(
                                                    const Duration(
                                                        milliseconds: 800), () {
                                                  Navigator.of(context)
                                                      .pop(true);
                                                });
                                                return const CustomAlert(
                                                  alertTitle:
                                                      'Please Register First',
                                                );
                                              });
                                          setState(() {
                                            buttonIsClicked = false;
                                          });
                                        } else {
                                          dynamic response = await ApiService()
                                              .sendOtp(
                                                  phoneNumberController.text);
                                          log('message $response');

                                          // ignore: use_build_context_synchronously
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => OtpScreen(
                                                register: false,
                                                phone:
                                                    phoneNumberController.text,
                                                otpNumber: response,
                                              ),
                                            ),
                                          );
                                          setState(() {
                                            buttonIsClicked = false;
                                          });
                                        }
                                      }
                                    }
                                  },
                                ),
                              ),
                        const SizedBox(
                          height: 10,
                        ),

                        ///////////////////////////////////
                        // SignIn with Google container //
                        /////////////////////////////////

                        // userNameController.text.isNotEmpty ||
                        //         phoneNumberController.text.isNotEmpty
                        //     ? const SizedBox.shrink()
                        //     : Padding(
                        //         padding:
                        //             const EdgeInsets.only(left: 24, right: 24),
                        //         child: InkWell(
                        //           child: Container(
                        //             child: Row(
                        //               children: [
                        //                 Container(
                        //                   height: 40.h,
                        //                   width: 40.w,
                        //                   decoration: const BoxDecoration(
                        //                     image: DecorationImage(
                        //                         image: AssetImage(
                        //                             'assets/Google.png'),
                        //                         fit: BoxFit.cover),
                        //                   ),
                        //                   // child: Image.asset('assets/buzz-logo.png'),
                        //                 ),
                        //                 SizedBox(
                        //                   width: 2.w,
                        //                 ),
                        //                 Expanded(
                        //                   child: Container(
                        //                     height: 40.h,
                        //                     width: 40.w,
                        //                     decoration: const BoxDecoration(
                        //                       color: Colors.blueAccent,
                        //                       borderRadius: BorderRadius.only(
                        //                         topRight: Radius.circular(10),
                        //                         bottomRight:
                        //                             Radius.circular(10),
                        //                       ),
                        //                     ),
                        //                     child: const Center(
                        //                       child: Text(
                        //                         'Sign in with google',
                        //                         style: TextStyle(
                        //                             fontSize: 16,
                        //                             fontWeight: FontWeight.bold,
                        //                             color: Colors.white),
                        //                       ),
                        //                     ),
                        //                   ),
                        //                 )
                        //               ],
                        //             ),
                        //           ),
                        //           onTap: () {},
                        //         ),
                        //       ),

                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("Don't have an account?"),
                              TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) =>
                                                const SignupScreen()));
                                  },
                                  child: const Text('Register here'))
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
                child: SizedBox(
                    height: 100.h, child: Image.asset('assets/buzz-logo.png')),
              ),
            ),
          ],
        ));
  }
}
