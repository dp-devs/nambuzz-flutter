import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:namebuzz/api/api_service.dart';
import 'package:namebuzz/const/const.dart';
import 'package:namebuzz/screen/otp_screen.dart';
import 'package:namebuzz/screen/signupfrom.dart';
import 'package:pinput/pinput.dart';

import '../const/widget/custom_alert.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController phoneNumbercontroller = TextEditingController();
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
                    height: 320.h,
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
                          'Get started for buzzing!',
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),

                        ///////////////////////////////////
                        // SignUp with Google container //
                        /////////////////////////////////

                        phoneNumbercontroller.text.isNotEmpty
                            ? Container()
                            : Padding(
                                padding: EdgeInsets.only(left: 24, right: 24),
                                child: InkWell(
                                  child: Container(
                                    child: Row(
                                      children: [
                                        Container(
                                          height: 40.h,
                                          width: 40.w,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                                image: AssetImage(
                                                    'assets/Google.png'),
                                                fit: BoxFit.cover),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 2.w,
                                        ),
                                        Expanded(
                                          child: Container(
                                            height: 40.h,
                                            width: 40.w,
                                            decoration: BoxDecoration(
                                              color: Colors.blueAccent,
                                              borderRadius: BorderRadius.only(
                                                topRight: Radius.circular(10),
                                                bottomRight:
                                                    Radius.circular(10),
                                              ),
                                            ),
                                            child: Center(
                                              child: Text(
                                                'Sign in with google',
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  onTap: () {},
                                ),
                              ),
                        SizedBox(
                          height: 16.h,
                        ),
                        phoneNumbercontroller.text.isNotEmpty
                            ? SizedBox.shrink()
                            : Text(
                                '-------------------- OR --------------------',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                        SizedBox(
                          height: 16.h,
                        ),

                        ////////////////////////////
                        // PhoneNumber InputField //
                        ////////////////////////////

                        Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: TextField(
                            controller: phoneNumbercontroller,
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                              hintText: 'Phone Number',
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 18.h,
                        ),

                        //////////////////////
                        // Send OTP button //
                        ////////////////////

                        Padding(
                          padding: EdgeInsets.only(left: 20, right: 20),
                          child: InkWell(
                            child: Container(
                              height: 44.h,
                              width: 310.w,
                              decoration: BoxDecoration(
                                  color: themeColor.withOpacity(0.95),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              child: Center(
                                child: Text(
                                  'Send OTP',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                            onTap: () async {
                              if (phoneNumbercontroller.length < 10) {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      Future.delayed(
                                          const Duration(milliseconds: 800),
                                          () {
                                        Navigator.of(context).pop(true);
                                      });
                                      return const CustomAlert(
                                        alertTitle:
                                            'Please Enter Valid Phone Number',
                                      );
                                    });
                              } else {
                                dynamic responce = await ApiService()
                                    .sendOtp(phoneNumbercontroller.text);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            OtpScreen(register: true)));
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Positioned.fill(
              bottom: 320.h,
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
