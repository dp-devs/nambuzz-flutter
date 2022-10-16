import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:namebuzz/screen/home.dart';
import 'package:namebuzz/screen/signup.dart';
import 'package:pinput/pinput.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool showUsernameBox = false;
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
      body: !showUsernameBox
          ? Stack(
              children: [
                Positioned.fill(
                  child: Align(
                    alignment: Alignment.center,
                    child: SingleChildScrollView(
                      child: Container(
                        height: 370.h,
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
                              'Login and buzz your name',
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
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
                                  hintText: 'Phone Number/Username',
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
                                      'Continue',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                  ),
                                ),
                                onTap: () {
                                  setState(() {
                                    showUsernameBox = true;
                                  });
                                },
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
                              height: 10.h,
                            ),
                            // Signup with google container
                            Padding(
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
                            SizedBox(
                              height: 16.h,
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
                                                builder: (_) =>
                                                    SignupScreen()));
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
                  bottom: 370.h,
                  child: Align(
                    alignment: Alignment.center,
                    child: Container(
                        height: 100.h,
                        child: Image.asset('assets/buzz-logo.png')),
                  ),
                ),
              ],
            )
          // Login password enter section****************************************
          : Stack(
              children: [
                Positioned.fill(
                  child: Align(
                    alignment: Alignment.center,
                    child: SingleChildScrollView(
                      child: Container(
                        height: 280.h,
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
                              'Welcome',
                              style: TextStyle(
                                  fontSize: 22.sp,
                                  color: Color(0XFFff7f50),
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            Text(
                              'Show Username',
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(
                              height: 16.h,
                            ),
                            //PhoneNumber InputField
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 20, right: 20),
                              child: TextField(
                                obscureText: true,
                                decoration: InputDecoration(
                                  hintText: 'Password',
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
                                      'Login',
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
                                          builder: (_) => HomeScreen()));
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
                  bottom: 280.h,
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
