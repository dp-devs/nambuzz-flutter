import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:namebuzz/const/const.dart';
import 'package:namebuzz/screen/home.dart';

import '../const/widget/custom_alert.dart';

class SignupFrom extends StatefulWidget {
  const SignupFrom({Key? key}) : super(key: key);

  @override
  State<SignupFrom> createState() => _SignupFromState();
}

class _SignupFromState extends State<SignupFrom> {
  TextEditingController userNameController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController retypePasswordController = TextEditingController();
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
                  height: 616.h,
                  width: 330.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
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
                          controller: userNameController,
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
                          controller: firstNameController,
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
                          controller: lastNameController,
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
                          controller: emailController,
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
                          controller: passwordController,
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
                          controller: retypePasswordController,
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
                                color: themeColor.withOpacity(0.95),
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
                          onTap: () {
                            if (userNameController.text.isNotEmpty) {
                              if (firstNameController.text.isNotEmpty) {
                                if (lastNameController.text.isNotEmpty) {
                                  if (emailController.text.isNotEmpty) {
                                    if (passwordController.text.isNotEmpty) {
                                      if (passwordController.text !=
                                          retypePasswordController.text) {
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
                                                    'Please check your passwor',
                                              );
                                            });
                                      } else {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (_) => HomeScreen()));
                                      }
                                    } else {
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            Future.delayed(
                                                const Duration(
                                                    milliseconds: 800), () {
                                              Navigator.of(context).pop(true);
                                            });
                                            return const CustomAlert(
                                              alertTitle: 'Enter Password',
                                            );
                                          });
                                    }
                                  } else {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          Future.delayed(
                                              const Duration(milliseconds: 500),
                                              () {
                                            Navigator.of(context).pop(true);
                                          });
                                          return const CustomAlert(
                                            alertTitle: 'Enter Email',
                                          );
                                        });
                                  }
                                } else {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        Future.delayed(
                                            const Duration(milliseconds: 500),
                                            () {
                                          Navigator.of(context).pop(true);
                                        });
                                        return const CustomAlert(
                                          alertTitle: 'Enter Last Name',
                                        );
                                      });
                                }
                              } else {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      Future.delayed(
                                          const Duration(milliseconds: 500),
                                          () {
                                        Navigator.of(context).pop(true);
                                      });
                                      return const CustomAlert(
                                        alertTitle: 'Enter First Name',
                                      );
                                    });
                              }
                            } else {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    Future.delayed(
                                        const Duration(milliseconds: 500), () {
                                      Navigator.of(context).pop(true);
                                    });
                                    return const CustomAlert(
                                      alertTitle: 'Enter Username',
                                    );
                                  });
                            }
                          },
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
                            mainAxisAlignment: MainAxisAlignment.center,
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
