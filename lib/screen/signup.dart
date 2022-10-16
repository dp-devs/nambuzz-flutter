import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:namebuzz/screen/signupfrom.dart';
import 'package:pinput/pinput.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool showOtpBox = false;
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
      backgroundColor: Color(0XFFff7f50),
      body: !showOtpBox
          ? Stack(
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
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 24, right: 24),
                              child: Container(
                                color: Colors.blueAccent,
                                child: Row(
                                  children: [
                                    // Signup with google container
                                    Container(
                                      height: 40.h,
                                      width: 40.w,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage(
                                                'assets/buzz-logo.png'),
                                            fit: BoxFit.cover),
                                      ),
                                      child:
                                          Image.asset('assets/buzz-logo.png'),
                                    ),
                                    SizedBox(
                                      width: 14.w,
                                    ),
                                    Text(
                                      'SignUp with google',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 16.h,
                            ),
                            Text(
                              '-------------------- OR --------------------',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 16.h,
                            ),
                            //PhoneNumber InputField
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 20, right: 20),
                              child: TextField(
                                decoration: InputDecoration(
                                  hintText: 'Phone Number',
                                  border: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 18.h,
                            ),
                            //Send OTP Button
                            Padding(
                              padding: EdgeInsets.only(left: 20, right: 20),
                              child: InkWell(
                                child: Container(
                                  height: 44.h,
                                  width: 310.w,
                                  decoration: BoxDecoration(
                                      color: Color(0XFFff7f50),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
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
                                onTap: () {
                                  setState(() {
                                    showOtpBox = true;
                                  });
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
                        height: 100.h,
                        child: Image.asset('assets/buzz-logo.png')),
                  ),
                ),
              ],
            )
          //Phone OTP verify Screen******************************************
          : Stack(
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
                              'Verify Mobile Number',
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),

                            SizedBox(
                              height: 16.h,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 40, right: 20),
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
                              // defaultPinTheme: defaultPinTheme,
                              // focusedPinTheme: focusedPinTheme,
                              // submittedPinTheme: submittedPinTheme,
                              // validator: (s) {
                              //   return s == '2222' ? null : 'Pin is incorrect';
                              // },
                              pinputAutovalidateMode:
                                  PinputAutovalidateMode.onSubmit,
                              showCursor: true,

                              // onCompleted: (pin) => print(pin),
                            ),
                            SizedBox(
                              height: 18.h,
                            ),
                            //OTP submit Button
                            Padding(
                              padding: EdgeInsets.only(left: 20, right: 20),
                              child: InkWell(
                                child: Container(
                                  height: 44.h,
                                  width: 310.w,
                                  decoration: BoxDecoration(
                                      color: Color(0XFFff7f50),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                  child: Center(
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
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => SignupFrom()));
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
                        height: 100.h,
                        child: Image.asset('assets/buzz-logo.png')),
                  ),
                ),
              ],
            ),
    );
  }
}
