import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignupFrom extends StatefulWidget {
  const SignupFrom({Key? key}) : super(key: key);

  @override
  State<SignupFrom> createState() => _SignupFromState();
}

class _SignupFromState extends State<SignupFrom> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0XFFff7f50),
      body: Stack(
        children: [
          Positioned.fill(
            child: Align(
              alignment: Alignment.center,
              child: SingleChildScrollView(
                child: Container(
                  height: 616.h,
                  width: 330.w,
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
                        'Register',
                        style: TextStyle(
                            fontSize: 24,
                            color: Colors.orangeAccent,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                      //Username InputField
                      Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Username',
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      //FirstName TextField
                      Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'First Name',
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      //LastName  TextField
                      Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Last Name',
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      //Email TextField
                      Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Email address',
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      // Password TextField
                      Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Password',
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      //Retype Password TextField
                      Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Retype Password',
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 14.h,
                      ),
                      //Register Button
                      Padding(
                        padding: EdgeInsets.only(left: 20, right: 20),
                        child: InkWell(
                          child: Container(
                            height: 44.h,
                            width: 310.w,
                            decoration: BoxDecoration(
                                color: Color(0XFFff7f50),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            child: Center(
                              child: Text(
                                'Register',
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                          onTap: () {},
                        ),
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      //Terms and conditions Text
                      Padding(
                        padding: const EdgeInsets.only(left: 4),
                        child: Container(
                          child: Row(
                            children: [
                              Text('By registering you accept our'),
                              TextButton(
                                onPressed: () {},
                                child: Text('terms and conditions?'),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned.fill(
            bottom: 616.h,
            child: Align(
              alignment: Alignment.center,
              child: Container(
                  height: 100.h, child: Image.asset('assets/buzz-logo.png')),
            ),
          ),
        ],
      ),
    );
  }
}
