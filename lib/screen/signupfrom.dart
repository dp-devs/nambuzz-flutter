import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:namebuzz/api/api_service.dart';
import 'package:namebuzz/const/const.dart';

import '../const/widget/custom_alert.dart';
import 'home.dart';

class SignupFrom extends StatefulWidget {
  const SignupFrom({Key? key, required this.phone}) : super(key: key);

  final String phone;

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
                  height: 616.h,
                  width: 330.w,
                  decoration: const BoxDecoration(
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
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.next,
                          decoration: const InputDecoration(
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
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.next,
                          decoration: const InputDecoration(
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
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.next,
                          decoration: const InputDecoration(
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
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          decoration: const InputDecoration(
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
                          keyboardType: TextInputType.text,
                          obscureText: true,
                          textInputAction: TextInputAction.next,
                          decoration: const InputDecoration(
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
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.done,
                          obscureText: true,
                          decoration: const InputDecoration(
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
                        padding: const EdgeInsets.only(left: 20, right: 20),
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
                                      'Register',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                            ),
                          ),
                          onTap: () async {
                            setState(() {
                              buttonIsClicked = true;
                            });
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
                                                    'Please check your password',
                                              );
                                            });
                                        setState(() {
                                          buttonIsClicked = false;
                                        });
                                      } else {
                                        bool emailValid = RegExp(
                                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                            .hasMatch(emailController.text);
                                        if (emailValid == true) {
                                          dynamic response = await ApiService()
                                              .checkEmail(emailController.text);
                                          log('check email == $response');
                                          if (response !=
                                              'User with same email does not exists') {
                                            showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  Future.delayed(
                                                      const Duration(
                                                          milliseconds: 800),
                                                      () {
                                                    Navigator.of(context)
                                                        .pop(true);
                                                  });
                                                  return const CustomAlert(
                                                    alertTitle:
                                                        'Use Different Email',
                                                  );
                                                });
                                            setState(() {
                                              buttonIsClicked = false;
                                            });
                                          } else {
                                            dynamic response =
                                                await ApiService()
                                                    .checkUsername(
                                                        userNameController
                                                            .text);
                                            log('check user == $response');
                                            if (response !=
                                                "User with same username does not exists") {
                                              showDialog(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    Future.delayed(
                                                        const Duration(
                                                            milliseconds: 800),
                                                        () {
                                                      Navigator.of(context)
                                                          .pop(true);
                                                    });
                                                    return const CustomAlert(
                                                      alertTitle:
                                                          'Use Different UserName',
                                                    );
                                                  });
                                              setState(() {
                                                buttonIsClicked = false;
                                              });
                                            } else {
                                              dynamic response =
                                                  await ApiService().addUser(
                                                      userNameController.text,
                                                      passwordController.text,
                                                      firstNameController.text,
                                                      lastNameController.text,
                                                      widget.phone,
                                                      emailController.text);
                                              log('Response on add user == $response');
                                              if (response !=
                                                  "User Registered") {
                                                showDialog(
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
                                                      Future.delayed(
                                                          const Duration(
                                                              milliseconds:
                                                                  400), () {
                                                        Navigator.of(context)
                                                            .pop(true);
                                                      });
                                                      return const CustomAlert(
                                                        alertTitle:
                                                            'Something Went Wrong',
                                                      );
                                                    });
                                                setState(() {
                                                  buttonIsClicked = false;
                                                });
                                              } else {
                                                // ignore: use_build_context_synchronously
                                                db.put('userLoggedIn', true);
                                                setState(() {
                                                  buttonIsClicked = false;
                                                });
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (_) =>
                                                            const HomeScreen()));
                                              }
                                            }
                                          }
                                        } else {
                                          showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                Future.delayed(
                                                    const Duration(
                                                        milliseconds: 500), () {
                                                  Navigator.of(context)
                                                      .pop(true);
                                                });
                                                return const CustomAlert(
                                                  alertTitle:
                                                      'Enter Valid Email',
                                                );
                                              });
                                          setState(() {
                                            buttonIsClicked = false;
                                          });
                                        }
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
                                      setState(() {
                                        buttonIsClicked = false;
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
                                    setState(() {
                                      buttonIsClicked = false;
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
                                  setState(() {
                                    buttonIsClicked = false;
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
                                setState(() {
                                  buttonIsClicked = false;
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
                              setState(() {
                                buttonIsClicked = false;
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
                              const Text('By registering you accept our'),
                              TextButton(
                                onPressed: () {},
                                child: const Text('terms and conditions?'),
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
              child: SizedBox(
                  height: 100.h, child: Image.asset('assets/buzz-logo.png')),
            ),
          ),
        ],
      ),
    );
  }
}
