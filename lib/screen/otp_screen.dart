import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:namebuzz/const/const.dart';
import 'package:namebuzz/screen/home.dart';
import 'package:namebuzz/screen/signupfrom.dart';
import 'package:pinput/pinput.dart';

import '../const/widget/custom_alert.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen(
      {Key? key,
      required this.register,
      required this.phone,
      required this.otpNumber})
      : super(key: key);
  final bool register;
  final String phone;
  final String otpNumber;

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  TextEditingController otpController = TextEditingController();
  var db = Hive.box('profileDetails');

  @override
  Widget build(BuildContext context) {
    //OTP code start
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(
          fontSize: 20,
          color: Color.fromRGBO(30, 60, 87, 1),
          fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        border: Border.all(color: const Color.fromRGBO(234, 239, 243, 1)),
        borderRadius: BorderRadius.circular(20),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: const Color.fromRGBO(114, 178, 238, 1)),
      borderRadius: BorderRadius.circular(8),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        color: const Color.fromRGBO(234, 239, 243, 1),
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
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  height: 320.h,
                  width: 335.w,
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
                        'Verify Mobile Number',
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),

                      SizedBox(
                        height: 16.h,
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 40, right: 20),
                        child: Text(
                          'OTP has been sent to you on your mobile number. Please enter below',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      //OTP InputField
                      Pinput(
                        controller: otpController,
                        length: 6,
                        // defaultPinTheme: defaultPinTheme,
                        // focusedPinTheme: focusedPinTheme,
                        // submittedPinTheme: submittedPinTheme,
                        // validator: (s) {
                        //   return s == '2222' ? null : 'Pin is incorrect';
                        // },
                        pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                        showCursor: true,

                        // onCompleted: (pin) => print(pin),
                      ),
                      SizedBox(
                        height: 18.h,
                      ),
                      //OTP submit Button
                      Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: InkWell(
                          child: Container(
                            height: 44.h,
                            width: 310.w,
                            decoration: BoxDecoration(
                                color: themeColor.withOpacity(0.95),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(10))),
                            child: const Center(
                              child: Text(
                                'Submit',
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                          onTap: () {
                            if (widget.otpNumber == otpController.text) {
                              if (widget.register == true) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) =>
                                            SignupFrom(phone: widget.phone)));
                              } else {
                                db.put('userLoggedIn', true);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => const HomeScreen()));
                              }
                            } else {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    Future.delayed(
                                        const Duration(milliseconds: 400), () {
                                      Navigator.of(context).pop(true);
                                    });
                                    return const CustomAlert(
                                      alertTitle: 'Please Check Otp Agsain',
                                    );
                                  });
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
              child: SizedBox(
                  height: 100.h, child: Image.asset('assets/buzz-logo.png')),
            ),
          ),
        ],
      ),
    );
  }
}
