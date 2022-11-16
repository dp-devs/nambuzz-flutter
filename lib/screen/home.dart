import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:image_editor_plus/image_editor_plus.dart';
import 'package:image_picker/image_picker.dart';
import 'package:namebuzz/api/api_service.dart';
import 'package:namebuzz/const/const.dart';
import 'package:namebuzz/const/widget/custom_button.dart';
import 'package:time_picker_sheet/widget/sheet.dart';
import 'package:time_picker_sheet/widget/time_picker.dart';

import '../const/widget/custom_alert.dart';
import 'add_post_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool status3 = false;
  bool isTopicAdded = false;
  File? _image;
  var editedImage;
  var bytes;
  var postedImage;
  bool _switchValue = false;

  List<dynamic> allPostsNonRev = [];
  List<dynamic> allPosts = [];
  var db = Hive.box('profileDetails');
  String selectedPostType = "Post";
  bool showImagePicker = false;
  var selectedCategory;

  Map<String, dynamic> mapCategoryList = {
    "assets/photography.png": "Photography",
    "assets/food.png": "Food",
    "assets/travel.png": "Travel",
    "assets/music.png": "Music",
    "assets/fashion.png": "Fashion",
    "assets/entertain.png": "Entertainment",
    "assets/fitness.png": "Health and Fitness",
    "assets/tech.png": "Technology",
    "assets/beauty.png": "Beauty and Cosmetics",
    "assets/sports.png": "Sports",
    "assets/art.png": "Art",
    "assets/event.png": "Events",
    "assets/news.png": "News",
    "assets/writing.png": "Writing",
    "assets/automobile.png": "Automobiles",
  };

  final _picker = ImagePicker();
  // Implementing the image picker
  Future<void> _openImagePicker(source) async {
    Navigator.pop(context);
    final XFile? pickedImage =
        // await _picker.pickImage(source: ImageSource.camera);
        await _picker.pickImage(source: source);
    if (pickedImage != null) {
      setState(() {
        isTopicAdded = false;
        _image = File(pickedImage.path);
      });
      bytes = await _image!.readAsBytes();
      // ignore: use_build_context_synchronously
      editedImage = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ImageEditor(
            image: bytes, // <-- Uint8List of image
          ),
        ),
      );
      // .then((value) => Navigator.push(
      //       context,
      //       MaterialPageRoute(builder: (context) => const AddPostPage()),
      //     ));
      if (editedImage != null) {
        // ignore: use_build_context_synchronously
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => AddPostPage(
                  image: bytes, buzzTimeSelected: dateTimeSelected)),
        );
        bytes = editedImage;
        postedImage = MemoryImage(bytes);
        setState(() {});
      }
    }
  }

  @override
  void initState() {
    callAllPost();
    if (db.get('allPost') == null) {
      allPosts = [];
    } else {
      allPostsNonRev = db.get('allPost');
      allPosts = allPostsNonRev.reversed.toList();
    }

    super.initState();
  }

  callAllPost() async {
    dynamic response = await ApiService().getAllPost();
    log('message as post as $response');
  }

  DateTime dateTimeSelected = DateTime.now();

  void _openTimePickerSheet(BuildContext context) async {
    final result = await TimePicker.show<DateTime?>(
      context: context,
      sheet: TimePickerSheet(
        sheetTitle: 'Set Buzz Duration',
        minuteTitle: 'Minute',
        hourTitle: 'Hour',
        saveButtonText: 'Save',
        saveButtonColor: Colors.green,
        sheetCloseIconColor: Colors.green,
        hourTitleStyle: const TextStyle(
            fontWeight: FontWeight.bold, color: Colors.green, fontSize: 16),
        minuteTitleStyle: const TextStyle(
            fontWeight: FontWeight.bold, color: Colors.green, fontSize: 16),
      ),
    );

    if (result != null) {
      setState(() {
        dateTimeSelected = result;
        showImagePicker == true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: postBuzzColor,
      // AppBar
      appBar: AppBar(
        backgroundColor: themeColor.withOpacity(0.95),
        leading: IconButton(
          onPressed: () {},
          icon: const CircleAvatar(
            backgroundColor: Colors.transparent,
            backgroundImage: AssetImage('assets/7.jpg'),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.military_tech,
            ),
            iconSize: 26,
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.group),
            iconSize: 24,
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.send,
            ),
            iconSize: 24,
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.notifications,
            ),
            iconSize: 24,
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.menu,
            ),
            iconSize: 24,
          ),
        ],
      ),
      //Floating Button
      floatingActionButton: Theme(
        data: Theme.of(context).copyWith(
          floatingActionButtonTheme: FloatingActionButtonThemeData(
            backgroundColor: postBuzzColor,
            extendedSizeConstraints:
                BoxConstraints.tightFor(width: 138.w, height: 40.h),
          ),
        ),
        child: FloatingActionButton.extended(
          onPressed: () {
            // 1st let's buzz pop button section
            showModalBottomSheet<void>(
              context: context,
              builder: (BuildContext context) {
                return Container(
                  height: 300.h,
                  color: Colors.white,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 14, right: 14),
                          child: Text(
                            'Start your buzz with the picture of your like either for fun or to showcase your talent, work, idea, creativity, DIY and enjoy watching how people are joining you with their buzzes of similar kind over your started buzz!',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 18.sp,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 22.h,
                        ),
                        InkWell(
                          child: Container(
                            width: 170.w,
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            decoration: BoxDecoration(
                              color: postBuzzColor,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(28)),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.grey,
                                  blurRadius: 10,
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  color: Colors.green,
                                  height: 34,
                                  child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Image.asset('assets/buzzadd.png'),
                                  ),
                                ),
                                const SizedBox(
                                  width: 14,
                                ),
                                const Text(
                                  "Let's buzz!",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                )
                              ],
                            ),
                          ),
                          onTap: () {
                            // 2nd Let's go pop button section
                            Navigator.pop(context);
                            showModalBottomSheet<void>(
                              context: context,
                              builder: (BuildContext context) {
                                return Container(
                                  height: 300,
                                  color: Colors.white,
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        // Row(
                                        //   mainAxisAlignment:
                                        //       MainAxisAlignment.end,
                                        //   children: [
                                        //     Container(
                                        //       margin: const EdgeInsets.only(
                                        //           bottom: 26, right: 16),
                                        //       child: const Text(
                                        //         '+ Add a topic',
                                        //         style: TextStyle(
                                        //           fontSize: 14,
                                        //           fontWeight: FontWeight.bold,
                                        //           color: Colors.green,
                                        //         ),
                                        //       ),
                                        //     ),
                                        //   ],
                                        // ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            // Open section
                                            GestureDetector(
                                              onTap: () {
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
                                                            'Coming Soon',
                                                      );
                                                    });
                                              },
                                              child: Column(
                                                children: [
                                                  SizedBox(
                                                    height: 60,
                                                    child: Image.asset(
                                                        'assets/globe3.gif'),
                                                  ),
                                                  SizedBox(
                                                    height: 10.h,
                                                  ),
                                                  const Text(
                                                    'Open',
                                                    style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black,
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                            // Social section
                                            GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  isTopicAdded = true;
                                                });
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
                                                            'Social Selected',
                                                      );
                                                    });
                                              },
                                              child: Container(
                                                decoration: const BoxDecoration(
                                                    // color: Colors.blue,
                                                    ),
                                                child: Column(
                                                  children: [
                                                    SizedBox(
                                                      height: 60,
                                                      child: Image.asset(
                                                          'assets/globe3.gif'),
                                                    ),
                                                    SizedBox(
                                                      height: 10.h,
                                                    ),
                                                    const Text(
                                                      'Social',
                                                      style: TextStyle(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                            // Closed section
                                            GestureDetector(
                                              onTap: () {
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
                                                            'Coming Soon',
                                                      );
                                                    });
                                              },
                                              child: Container(
                                                child: Column(
                                                  children: [
                                                    SizedBox(
                                                      height: 60,
                                                      child: Image.asset(
                                                          'assets/globe3.gif'),
                                                    ),
                                                    SizedBox(
                                                      height: 10.h,
                                                    ),
                                                    const Text(
                                                      'Closed',
                                                      style: TextStyle(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Divider(
                                          thickness: 1,
                                          color: Colors.black.withOpacity(0.20),
                                        ),
                                        const SizedBox(
                                          height: 18,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              'Start a buzz',
                                              style: TextStyle(
                                                fontSize: 16.sp,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 4.w,
                                            ),
                                            Text(
                                              'Open to everyone',
                                              style: TextStyle(
                                                fontSize: 16.sp,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 18.h,
                                        ),
                                        InkWell(
                                          child: Container(
                                            width: 160.w,
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 10),
                                            decoration: const BoxDecoration(
                                              color: Colors.green,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(28)),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey,
                                                  blurRadius: 6,
                                                ),
                                              ],
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                SizedBox(
                                                  height: 34,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            4.0),
                                                    child: Image.asset(
                                                        'assets/buzzadd.png'),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 14,
                                                ),
                                                const Text(
                                                  "Let's go",
                                                  style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          onTap: () {
                                            if (isTopicAdded == false) {
                                              showDialog(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    Future.delayed(
                                                        const Duration(
                                                            milliseconds: 400),
                                                        () {
                                                      Navigator.of(context)
                                                          .pop(true);
                                                    });
                                                    return const CustomAlert(
                                                      alertTitle:
                                                          'Please choose a topic',
                                                    );
                                                  });
                                            } else {
                                              // 3rd Section
                                              Navigator.pop(context);
                                              showModalBottomSheet<void>(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return StatefulBuilder(
                                                      builder: (context,
                                                          StateSetter
                                                              setState) {
                                                    return Container(
                                                      height: 260,
                                                      color: Colors.white,
                                                      child: Center(
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          children: <Widget>[
                                                            const SizedBox(
                                                              height: 18,
                                                            ),
                                                            Text(
                                                              'Your post can be buzzed',
                                                              style: TextStyle(
                                                                fontSize: 16.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                    .black,
                                                              ),
                                                            ),

                                                            SizedBox(
                                                              height: 18.h,
                                                            ),
                                                            // Toggle button
                                                            Transform.scale(
                                                              scale: 0.9,
                                                              child:
                                                                  CupertinoSwitch(
                                                                value:
                                                                    _switchValue,
                                                                onChanged:
                                                                    (value) {
                                                                  setState(() {
                                                                    _switchValue =
                                                                        value;
                                                                  });
                                                                  if (_switchValue ==
                                                                      true) {
                                                                    setState(
                                                                        () {
                                                                      selectedPostType =
                                                                          "Post & Buzz";
                                                                    });
                                                                  } else {
                                                                    setState(
                                                                        () {
                                                                      selectedPostType =
                                                                          "Post";
                                                                    });
                                                                  }
                                                                },
                                                              ),
                                                            ),

                                                            Text(
                                                                "$selectedPostType"),

                                                            SizedBox(
                                                              height: 20.h,
                                                            ),
                                                            CustomButton(
                                                              width: 235,
                                                              height: 50,
                                                              isBlue: false,
                                                              isRed: false,
                                                              radius: 60,
                                                              buttonText:
                                                                  'Next',
                                                              customStyle: true,
                                                              styleText:
                                                                  TextStyle(
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                              onTap: () {
                                                                setState(() {
                                                                  _switchValue =
                                                                      false;
                                                                });
                                                                Navigator.pop(
                                                                    context);
                                                                selectedPostType ==
                                                                        "Post & Buzz"
                                                                    ? setState(
                                                                        () {
                                                                        showModalBottomSheet<
                                                                            void>(
                                                                          context:
                                                                              context,
                                                                          builder:
                                                                              (BuildContext context) {
                                                                            return Container(
                                                                              height: 260,
                                                                              color: Colors.white,
                                                                              child: Center(
                                                                                child: Column(
                                                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                                                  mainAxisSize: MainAxisSize.min,
                                                                                  children: <Widget>[
                                                                                    const SizedBox(
                                                                                      height: 18,
                                                                                    ),
                                                                                    Row(
                                                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                                                      children: [
                                                                                        Text(
                                                                                          'Start a buzz',
                                                                                          style: TextStyle(
                                                                                            fontSize: 16.sp,
                                                                                          ),
                                                                                        ),
                                                                                        SizedBox(
                                                                                          width: 4.w,
                                                                                        ),
                                                                                        Text(
                                                                                          'Choose from : -->',
                                                                                          style: TextStyle(
                                                                                            fontSize: 16.sp,
                                                                                            fontWeight: FontWeight.bold,
                                                                                            color: Colors.black,
                                                                                          ),
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                    SizedBox(
                                                                                      height: 18.h,
                                                                                    ),
                                                                                    InkWell(
                                                                                      child: Container(
                                                                                        width: 160.w,
                                                                                        padding: const EdgeInsets.symmetric(vertical: 10),
                                                                                        decoration: const BoxDecoration(
                                                                                          color: Colors.green,
                                                                                          borderRadius: BorderRadius.all(Radius.circular(28)),
                                                                                          boxShadow: [
                                                                                            BoxShadow(
                                                                                              color: Colors.grey,
                                                                                              blurRadius: 6,
                                                                                            ),
                                                                                          ],
                                                                                        ),
                                                                                        child: Row(
                                                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                                                          children: const [
                                                                                            SizedBox(
                                                                                              height: 30,
                                                                                              child: Padding(
                                                                                                padding: EdgeInsets.all(4.0),
                                                                                                child: Icon(
                                                                                                  Icons.photo_library,
                                                                                                  color: Colors.white,
                                                                                                ),
                                                                                              ),
                                                                                            ),
                                                                                            SizedBox(
                                                                                              width: 14,
                                                                                            ),
                                                                                            Text(
                                                                                              "Gallery",
                                                                                              style: TextStyle(
                                                                                                fontSize: 20,
                                                                                                fontWeight: FontWeight.bold,
                                                                                                color: Colors.white,
                                                                                              ),
                                                                                            )
                                                                                          ],
                                                                                        ),
                                                                                      ),
                                                                                      onTap: () {
                                                                                        _openImagePicker(ImageSource.gallery);
                                                                                      },
                                                                                    ),
                                                                                    SizedBox(
                                                                                      height: 20.h,
                                                                                    ),
                                                                                    InkWell(
                                                                                      child: Container(
                                                                                        width: 160.w,
                                                                                        padding: const EdgeInsets.symmetric(vertical: 10),
                                                                                        decoration: const BoxDecoration(
                                                                                          color: Colors.green,
                                                                                          borderRadius: BorderRadius.all(Radius.circular(28)),
                                                                                          boxShadow: [
                                                                                            BoxShadow(
                                                                                              color: Colors.grey,
                                                                                              blurRadius: 6,
                                                                                            ),
                                                                                          ],
                                                                                        ),
                                                                                        child: Row(
                                                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                                                          children: const [
                                                                                            SizedBox(
                                                                                              height: 30,
                                                                                              child: Padding(
                                                                                                padding: EdgeInsets.all(4.0),
                                                                                                child: Icon(
                                                                                                  Icons.photo_camera,
                                                                                                  color: Colors.white,
                                                                                                ),
                                                                                              ),
                                                                                            ),
                                                                                            SizedBox(
                                                                                              width: 14,
                                                                                            ),
                                                                                            Text(
                                                                                              "Camera",
                                                                                              style: TextStyle(
                                                                                                fontSize: 20,
                                                                                                fontWeight: FontWeight.bold,
                                                                                                color: Colors.white,
                                                                                              ),
                                                                                            )
                                                                                          ],
                                                                                        ),
                                                                                      ),
                                                                                      onTap: () {
                                                                                        _openImagePicker(ImageSource.camera);
                                                                                      },
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                            );
                                                                          },
                                                                        );
                                                                        _openTimePickerSheet(
                                                                            context);
                                                                      })
                                                                    : showModalBottomSheet<
                                                                        void>(
                                                                        context:
                                                                            context,
                                                                        builder:
                                                                            (BuildContext
                                                                                context) {
                                                                          return Container(
                                                                            height:
                                                                                260,
                                                                            color:
                                                                                Colors.white,
                                                                            child:
                                                                                Center(
                                                                              child: Column(
                                                                                mainAxisAlignment: MainAxisAlignment.center,
                                                                                mainAxisSize: MainAxisSize.min,
                                                                                children: <Widget>[
                                                                                  const SizedBox(
                                                                                    height: 18,
                                                                                  ),
                                                                                  Row(
                                                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                                                    children: [
                                                                                      Text(
                                                                                        'Start a buzz',
                                                                                        style: TextStyle(
                                                                                          fontSize: 16.sp,
                                                                                        ),
                                                                                      ),
                                                                                      SizedBox(
                                                                                        width: 4.w,
                                                                                      ),
                                                                                      Text(
                                                                                        'Choose from : -->',
                                                                                        style: TextStyle(
                                                                                          fontSize: 16.sp,
                                                                                          fontWeight: FontWeight.bold,
                                                                                          color: Colors.black,
                                                                                        ),
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                  SizedBox(
                                                                                    height: 18.h,
                                                                                  ),
                                                                                  InkWell(
                                                                                    child: Container(
                                                                                      width: 160.w,
                                                                                      padding: const EdgeInsets.symmetric(vertical: 10),
                                                                                      decoration: const BoxDecoration(
                                                                                        color: Colors.green,
                                                                                        borderRadius: BorderRadius.all(Radius.circular(28)),
                                                                                        boxShadow: [
                                                                                          BoxShadow(
                                                                                            color: Colors.grey,
                                                                                            blurRadius: 6,
                                                                                          ),
                                                                                        ],
                                                                                      ),
                                                                                      child: Row(
                                                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                                                        children: const [
                                                                                          SizedBox(
                                                                                            height: 30,
                                                                                            child: Padding(
                                                                                              padding: EdgeInsets.all(4.0),
                                                                                              child: Icon(
                                                                                                Icons.photo_library,
                                                                                                color: Colors.white,
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                          SizedBox(
                                                                                            width: 14,
                                                                                          ),
                                                                                          Text(
                                                                                            "Gallery",
                                                                                            style: TextStyle(
                                                                                              fontSize: 20,
                                                                                              fontWeight: FontWeight.bold,
                                                                                              color: Colors.white,
                                                                                            ),
                                                                                          )
                                                                                        ],
                                                                                      ),
                                                                                    ),
                                                                                    onTap: () {
                                                                                      _openImagePicker(ImageSource.gallery);
                                                                                    },
                                                                                  ),
                                                                                  SizedBox(
                                                                                    height: 20.h,
                                                                                  ),
                                                                                  InkWell(
                                                                                    child: Container(
                                                                                      width: 160.w,
                                                                                      padding: const EdgeInsets.symmetric(vertical: 10),
                                                                                      decoration: const BoxDecoration(
                                                                                        color: Colors.green,
                                                                                        borderRadius: BorderRadius.all(Radius.circular(28)),
                                                                                        boxShadow: [
                                                                                          BoxShadow(
                                                                                            color: Colors.grey,
                                                                                            blurRadius: 6,
                                                                                          ),
                                                                                        ],
                                                                                      ),
                                                                                      child: Row(
                                                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                                                        children: const [
                                                                                          SizedBox(
                                                                                            height: 30,
                                                                                            child: Padding(
                                                                                              padding: EdgeInsets.all(4.0),
                                                                                              child: Icon(
                                                                                                Icons.photo_camera,
                                                                                                color: Colors.white,
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                          SizedBox(
                                                                                            width: 14,
                                                                                          ),
                                                                                          Text(
                                                                                            "Camera",
                                                                                            style: TextStyle(
                                                                                              fontSize: 20,
                                                                                              fontWeight: FontWeight.bold,
                                                                                              color: Colors.white,
                                                                                            ),
                                                                                          )
                                                                                        ],
                                                                                      ),
                                                                                    ),
                                                                                    onTap: () {
                                                                                      _openImagePicker(ImageSource.camera);
                                                                                    },
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                          );
                                                                        },
                                                                      );
                                                                // :
                                                                // // Post & Buzz
                                                                // showModalBottomSheet<
                                                                //     void>(
                                                                //     context:
                                                                //         context,
                                                                //     builder:
                                                                //         (BuildContext
                                                                //             context) {
                                                                //       return StatefulBuilder(builder:
                                                                //           (context, StateSetter setState) {
                                                                //         return Container(
                                                                //           height: 260,
                                                                //           color: Colors.white,
                                                                //           child: Center(
                                                                //             child: Column(
                                                                //               mainAxisAlignment: MainAxisAlignment.center,
                                                                //               mainAxisSize: MainAxisSize.min,
                                                                //               children: <Widget>[
                                                                //                 const SizedBox(
                                                                //                   height: 18,
                                                                //                 ),
                                                                //                 Center(
                                                                //                   child: SizedBox(
                                                                //                     width: 300.w,
                                                                //                     child: Text(
                                                                //                       'Select Time Limit upto which your post can be buzzed',
                                                                //                       textAlign: TextAlign.center,
                                                                //                       style: TextStyle(
                                                                //                         fontSize: 16.sp,
                                                                //                         fontWeight: FontWeight.bold,
                                                                //                         color: Colors.black,
                                                                //                       ),
                                                                //                     ),
                                                                //                   ),
                                                                //                 ),

                                                                //                 SizedBox(
                                                                //                   height: 18.h,
                                                                //                 ),
                                                                //                 //
                                                                //                 InkWell(
                                                                //                     onTap: () {
                                                                //                       setState(() {
                                                                //                         _openTimePickerSheet(context);
                                                                //                       });
                                                                //                     },
                                                                //                     child: Container(
                                                                //                       height: 50.h,
                                                                //                       width: 50.w,
                                                                //                       child: Text(
                                                                //                         'Choose Time',
                                                                //                         style: TextStyle(color: Colors.red),
                                                                //                       ),
                                                                //                     )),

                                                                //                 SizedBox(
                                                                //                   height: 20.h,
                                                                //                 ),
                                                                //                 CustomButton(
                                                                //                   width: 235,
                                                                //                   height: 50,
                                                                //                   isBlue: false,
                                                                //                   isRed: false,
                                                                //                   radius: 60,
                                                                //                   buttonText: 'Next',
                                                                //                   customStyle: true,
                                                                //                   styleText: TextStyle(
                                                                //                     color: Colors.white,
                                                                //                   ),
                                                                //                   onTap: () {},
                                                                //                   requireIcon: false,
                                                                //                   isSvg: false,
                                                                //                   prefixIcon: false,
                                                                //                   buttonClicked: false,
                                                                //                   prefixIconImage: '',
                                                                //                   isTransparent: false,
                                                                //                 ),
                                                                //               ],
                                                                //             ),
                                                                //           ),
                                                                //         );
                                                                //       });
                                                                //     },
                                                                //   );
                                                              },
                                                              requireIcon:
                                                                  false,
                                                              isSvg: false,
                                                              prefixIcon: false,
                                                              buttonClicked:
                                                                  false,
                                                              prefixIconImage:
                                                                  '',
                                                              isTransparent:
                                                                  false,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    );
                                                  });
                                                },
                                              );
                                            }
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
          label: const Text(
            'Start a Buzz',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          icon: Container(
            padding: const EdgeInsets.all(2),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(16)),
            ),
            child: Image.asset(
              'assets/buzzadd.png',
              width: 26.w,
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      //Buttom_Navbar
      bottomNavigationBar: BottomAppBar(
        color: themeColor.withOpacity(0.95),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 18),
              child: IconButton(
                onPressed: () {},
                icon: Image.asset(
                  'assets/home solid.png',
                  width: 28.w,
                  color: Colors.white,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 18),
              child: IconButton(
                onPressed: () {
                  db.put('userLoggedIn', false);
                  log('User Logged out');
                },
                icon: Image.asset(
                  'assets/globe3.gif',
                  width: 28.w,
                ),
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            db.get('allPost') == null
                ? Column(
                    children: [
                      SizedBox(
                        height: 300.h,
                      ),
                      Center(
                        child: Text(
                          'Welcome to NameBuzz',
                          style: TextStyle(
                            fontSize: 24.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  )
                :
                // Storis showing section ***************************************

                //1st Post ******************************************************
                Container(
                    padding: const EdgeInsets.only(bottom: 8),
                    margin: const EdgeInsets.only(top: 10),
                    //color: Colors.white,
                    child: Column(
                      children: [
                        //1st section

                        // 2nd section
                        SizedBox(
                          width: double.infinity,
                          child: ListView.builder(
                              shrinkWrap: true,
                              physics: const BouncingScrollPhysics(),
                              itemCount: allPosts.length,
                              itemBuilder: (context, index) {
                                selectedCategory = mapCategoryList.entries
                                    .firstWhere((entry) =>
                                        entry.value ==
                                        allPosts[index]['category'])
                                    .key;
                                log('message as $selectedCategory');
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 15.0),
                                  child: Container(
                                    color: Colors.white,
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                SizedBox(
                                                  width: 10.w,
                                                ),
                                                Container(
                                                  child: allPosts.isNotEmpty
                                                      ? CircleAvatar(
                                                          child: Image.asset(
                                                              "$selectedCategory"),
                                                        )
                                                      : IconButton(
                                                          onPressed: () {},
                                                          icon: const Icon(Icons
                                                              .photo_camera),
                                                          iconSize: 20,
                                                        ),
                                                ),
                                                SizedBox(
                                                  width: 10.w,
                                                ),
                                                Container(
                                                  child: Text(
                                                    '${allPosts[index]['title']}',
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            IconButton(
                                              onPressed: () {},
                                              icon: const Icon(Icons.more_vert),
                                              iconSize: 20,
                                            ),
                                          ],
                                        ),
                                        const Divider(
                                          thickness: 1,
                                          color: Colors.black,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Container(
                                                  child: IconButton(
                                                    onPressed: () {},
                                                    icon: const CircleAvatar(
                                                      backgroundImage: AssetImage(
                                                          'assets/buzz-logo.png'),
                                                      backgroundColor:
                                                          Colors.transparent,
                                                    ),
                                                  ),
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 6),
                                                      child: Row(
                                                        children: const [
                                                          Text(
                                                            'Namebuzz',
                                                            style: TextStyle(
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    left: 6),
                                                            child: Icon(
                                                              Icons.verified,
                                                              size: 18,
                                                              color: Color(
                                                                  0XFFFFC312),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    const Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 6),
                                                      child: Text(
                                                        '1m ago',
                                                        style: TextStyle(
                                                          fontSize: 12,
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  // 'This is post title. This is post title. This is post title. This is post title. This is post title. This is post title',
                                                  '${allPosts[index]['buzzTimeSelected']}',
                                                  style: const TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.blue
                                                      // fontFamily: 'Roboto',
                                                      ),
                                                ),
                                                IconButton(
                                                  onPressed: () {},
                                                  icon: const Icon(
                                                      Icons.bookmark_outline),
                                                  iconSize: 22,
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        // 3rd section
                                        Container(
                                          margin: const EdgeInsets.all(6),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 8),
                                                child: Text(
                                                  // 'This is post title. This is post title. This is post title. This is post title. This is post title. This is post title',
                                                  '${allPosts[index]['caption']}',
                                                  style: const TextStyle(
                                                    fontSize: 14,
                                                    // fontFamily: 'Roboto',
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 8),
                                                child: Text(
                                                  // 'This is post title. This is post title. This is post title. This is post title. This is post title. This is post title',
                                                  '${allPosts[index]['hashtags']}',
                                                  style: const TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.blue
                                                      // fontFamily: 'Roboto',
                                                      ),
                                                ),
                                              ),
                                              allPosts.isEmpty
                                                  ? const Image(
                                                      image: AssetImage(
                                                          'assets/1.jpg'))
                                                  // : Image.file(postedImage),
                                                  : Image.memory(
                                                      allPosts[index]['image']),
                                            ],
                                          ),
                                        ),
                                        //

                                        // 4th section
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            InkWell(
                                              child: Container(
                                                height: 24.h,
                                                width: 24.w,
                                                decoration: const BoxDecoration(
                                                  image: DecorationImage(
                                                    image: AssetImage(
                                                        'assets/buzzpost.png'),
                                                  ),
                                                ),
                                              ),
                                              onTap: () {},
                                            ),
                                            IconButton(
                                                onPressed: () {},
                                                icon: const Icon(
                                                    Icons.favorite_outline)),
                                            IconButton(
                                                onPressed: () {},
                                                icon: const Icon(
                                                    Icons.forum_outlined)),
                                            IconButton(
                                                onPressed: () {},
                                                icon: const Icon(
                                                    Icons.comment_outlined)),
                                            IconButton(
                                                onPressed: () {},
                                                icon: const Icon(
                                                    Icons.share_outlined)),
                                          ],
                                        ),
                                        // 5th section
                                        Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 18),
                                              child: Text(
                                                '14K',
                                                style: TextStyle(
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.bold,
                                                  color:
                                                      const Color(0XFFFFC312),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 2,
                                            ),
                                            const Text(
                                              'Likes',
                                              style: TextStyle(fontSize: 14),
                                            )
                                          ],
                                        ),
                                        // 6th section
                                        const SizedBox(
                                          height: 4,
                                        ),
                                        // 7th section
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 12),
                                              child: Row(
                                                children: [
                                                  Text(
                                                    'Prashant',
                                                    style: TextStyle(
                                                        fontSize: 10.sp),
                                                  ),
                                                  SizedBox(
                                                    width: 1.w,
                                                  ),
                                                  Text('and',
                                                      style: TextStyle(
                                                          fontSize: 10.sp)),
                                                  SizedBox(
                                                    width: 1.w,
                                                  ),
                                                  Text('55',
                                                      style: TextStyle(
                                                        fontSize: 10.sp,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      )),
                                                  SizedBox(
                                                    width: 1.w,
                                                  ),
                                                  Text('others comment',
                                                      style: TextStyle(
                                                          fontSize: 10.sp)),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              margin: const EdgeInsets.only(
                                                  right: 14),
                                              child: Row(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 4),
                                                    child: SizedBox(
                                                      height: 18.h,
                                                      width: 18.w,
                                                      child: Image.asset(
                                                          'assets/buzzadd.png'),
                                                    ),
                                                  ),
                                                  Text(
                                                    '20',
                                                    style: TextStyle(
                                                      fontSize: 10.sp,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 2.w,
                                                  ),
                                                  Text(
                                                    'people have buzz on this',
                                                    style: TextStyle(
                                                        fontSize: 10.sp),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }),
                        )
                      ],
                    ),
                  ),
            // Main column children
          ],
        ),
      ),
    );
  }
}

/*

import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:image_editor_plus/image_editor_plus.dart';
import 'package:image_picker/image_picker.dart';
import 'package:namebuzz/api/api_service.dart';
import 'package:namebuzz/const/const.dart';
import 'package:namebuzz/const/widget/custom_button.dart';
import 'package:time_picker_sheet/widget/sheet.dart';
import 'package:time_picker_sheet/widget/time_picker.dart';

import '../const/widget/custom_alert.dart';
import 'add_post_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool status3 = false;
  bool isTopicAdded = false;
  File? _image;
  var editedImage;
  var bytes;
  var postedImage;
  bool _switchValue = false;

  List<dynamic> allPostsNonRev = [];
  List<dynamic> allPosts = [];
  Map<String, dynamic> allPostsFromServer = {};
  var db = Hive.box('profileDetails');
  String selectedPostType = "Post";
  bool showImagePicker = false;
  var selectedCategory;
  bool loadData = false;

  Map<String, dynamic> mapCategoryList = {
    "assets/photography.png": "Photography",
    "assets/food.png": "Food",
    "assets/travel.png": "Travel",
    "assets/music.png": "Music",
    "assets/fashion.png": "Fashion",
    "assets/entertain.png": "Entertainment",
    "assets/fitness.png": "Health and Fitness",
    "assets/tech.png": "Technology",
    "assets/beauty.png": "Beauty and Cosmetics",
    "assets/sports.png": "Sports",
    "assets/art.png": "Art",
    "assets/event.png": "Events",
    "assets/news.png": "News",
    "assets/writing.png": "Writing",
    "assets/automobile.png": "Automobiles",
  };

  final _picker = ImagePicker();
  // Implementing the image picker
  Future<void> _openImagePicker(source) async {
    Navigator.pop(context);
    final XFile? pickedImage =
        // await _picker.pickImage(source: ImageSource.camera);
        await _picker.pickImage(source: source);
    if (pickedImage != null) {
      setState(() {
        isTopicAdded = false;
        _image = File(pickedImage.path);
      });
      bytes = await _image!.readAsBytes();
      // ignore: use_build_context_synchronously
      editedImage = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ImageEditor(
            image: bytes, // <-- Uint8List of image
          ),
        ),
      );
      // .then((value) => Navigator.push(
      //       context,
      //       MaterialPageRoute(builder: (context) => const AddPostPage()),
      //     ));
      if (editedImage != null) {
        // ignore: use_build_context_synchronously
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => AddPostPage(
                  image: bytes, buzzTimeSelected: dateTimeSelected)),
        );
        bytes = editedImage;
        postedImage = MemoryImage(bytes);
        setState(() {});
      }
    }
  }

  @override
  void initState() {
    callAllPost();

    super.initState();
  }

  callAllPost() async {
    setState(() {
      loadData = true;
    });
    dynamic response = await ApiService().getAllPost();
    setState(() {
      loadData = false;
    });
    log('message as post as $response');
    if (response != null) {
      setState(() {
        loadData = false;
        allPostsFromServer = response;
      });
    } else {
      setState(() {
        loadData = false;
      });
      if (allPostsFromServer.isEmpty) {
        if (db.get('allPost') == null) {
          allPosts = [];
        } else {
          allPostsNonRev = db.get('allPost');
          allPosts = allPostsNonRev.reversed.toList();
        }
      }
    }
  }

  DateTime dateTimeSelected = DateTime.now();

  void _openTimePickerSheet(BuildContext context) async {
    final result = await TimePicker.show<DateTime?>(
      context: context,
      sheet: TimePickerSheet(
        sheetTitle: 'Set Buzz Duration',
        minuteTitle: 'Minute',
        hourTitle: 'Hour',
        saveButtonText: 'Save',
        saveButtonColor: Colors.green,
        sheetCloseIconColor: Colors.green,
        hourTitleStyle: const TextStyle(
            fontWeight: FontWeight.bold, color: Colors.green, fontSize: 16),
        minuteTitleStyle: const TextStyle(
            fontWeight: FontWeight.bold, color: Colors.green, fontSize: 16),
      ),
    );

    if (result != null) {
      setState(() {
        dateTimeSelected = result;
        showImagePicker == true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: postBuzzColor,
      // AppBar
      appBar: AppBar(
        backgroundColor: themeColor.withOpacity(0.95),
        leading: IconButton(
          onPressed: () {},
          icon: const CircleAvatar(
            backgroundColor: Colors.transparent,
            backgroundImage: AssetImage('assets/7.jpg'),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.military_tech,
            ),
            iconSize: 26,
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.group),
            iconSize: 24,
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.send,
            ),
            iconSize: 24,
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.notifications,
            ),
            iconSize: 24,
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.menu,
            ),
            iconSize: 24,
          ),
        ],
      ),
      //Floating Button
      floatingActionButton: Theme(
        data: Theme.of(context).copyWith(
          floatingActionButtonTheme: FloatingActionButtonThemeData(
            backgroundColor: postBuzzColor,
            extendedSizeConstraints:
                BoxConstraints.tightFor(width: 138.w, height: 40.h),
          ),
        ),
        child: FloatingActionButton.extended(
          onPressed: () {
            // 1st let's buzz pop button section
            showModalBottomSheet<void>(
              context: context,
              builder: (BuildContext context) {
                return Container(
                  height: 300.h,
                  color: Colors.white,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 14, right: 14),
                          child: Text(
                            'Start your buzz with the picture of your like either for fun or to showcase your talent, work, idea, creativity, DIY and enjoy watching how people are joining you with their buzzes of similar kind over your started buzz!',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 18.sp,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 22.h,
                        ),
                        InkWell(
                          child: Container(
                            width: 170.w,
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            decoration: BoxDecoration(
                              color: postBuzzColor,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(28)),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.grey,
                                  blurRadius: 10,
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  color: Colors.green,
                                  height: 34,
                                  child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Image.asset('assets/buzzadd.png'),
                                  ),
                                ),
                                const SizedBox(
                                  width: 14,
                                ),
                                const Text(
                                  "Let's buzz!",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                )
                              ],
                            ),
                          ),
                          onTap: () {
                            // 2nd Let's go pop button section
                            Navigator.pop(context);
                            showModalBottomSheet<void>(
                              context: context,
                              builder: (BuildContext context) {
                                return Container(
                                  height: 300,
                                  color: Colors.white,
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        // Row(
                                        //   mainAxisAlignment:
                                        //       MainAxisAlignment.end,
                                        //   children: [
                                        //     Container(
                                        //       margin: const EdgeInsets.only(
                                        //           bottom: 26, right: 16),
                                        //       child: const Text(
                                        //         '+ Add a topic',
                                        //         style: TextStyle(
                                        //           fontSize: 14,
                                        //           fontWeight: FontWeight.bold,
                                        //           color: Colors.green,
                                        //         ),
                                        //       ),
                                        //     ),
                                        //   ],
                                        // ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            // Open section
                                            GestureDetector(
                                              onTap: () {
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
                                                            'Coming Soon',
                                                      );
                                                    });
                                              },
                                              child: Column(
                                                children: [
                                                  SizedBox(
                                                    height: 60,
                                                    child: Image.asset(
                                                        'assets/globe3.gif'),
                                                  ),
                                                  SizedBox(
                                                    height: 10.h,
                                                  ),
                                                  const Text(
                                                    'Open',
                                                    style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black,
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                            // Social section
                                            GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  isTopicAdded = true;
                                                });
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
                                                            'Social Selected',
                                                      );
                                                    });
                                              },
                                              child: Container(
                                                decoration: const BoxDecoration(
                                                    // color: Colors.blue,
                                                    ),
                                                child: Column(
                                                  children: [
                                                    SizedBox(
                                                      height: 60,
                                                      child: Image.asset(
                                                          'assets/globe3.gif'),
                                                    ),
                                                    SizedBox(
                                                      height: 10.h,
                                                    ),
                                                    const Text(
                                                      'Social',
                                                      style: TextStyle(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                            // Closed section
                                            GestureDetector(
                                              onTap: () {
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
                                                            'Coming Soon',
                                                      );
                                                    });
                                              },
                                              child: Container(
                                                child: Column(
                                                  children: [
                                                    SizedBox(
                                                      height: 60,
                                                      child: Image.asset(
                                                          'assets/globe3.gif'),
                                                    ),
                                                    SizedBox(
                                                      height: 10.h,
                                                    ),
                                                    const Text(
                                                      'Closed',
                                                      style: TextStyle(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Divider(
                                          thickness: 1,
                                          color: Colors.black.withOpacity(0.20),
                                        ),
                                        const SizedBox(
                                          height: 18,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              'Start a buzz',
                                              style: TextStyle(
                                                fontSize: 16.sp,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 4.w,
                                            ),
                                            Text(
                                              'Open to everyone',
                                              style: TextStyle(
                                                fontSize: 16.sp,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 18.h,
                                        ),
                                        InkWell(
                                          child: Container(
                                            width: 160.w,
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 10),
                                            decoration: const BoxDecoration(
                                              color: Colors.green,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(28)),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey,
                                                  blurRadius: 6,
                                                ),
                                              ],
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                SizedBox(
                                                  height: 34,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            4.0),
                                                    child: Image.asset(
                                                        'assets/buzzadd.png'),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 14,
                                                ),
                                                const Text(
                                                  "Let's go",
                                                  style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          onTap: () {
                                            if (isTopicAdded == false) {
                                              showDialog(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    Future.delayed(
                                                        const Duration(
                                                            milliseconds: 400),
                                                        () {
                                                      Navigator.of(context)
                                                          .pop(true);
                                                    });
                                                    return const CustomAlert(
                                                      alertTitle:
                                                          'Please choose a topic',
                                                    );
                                                  });
                                            } else {
                                              // 3rd Section
                                              Navigator.pop(context);
                                              showModalBottomSheet<void>(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return StatefulBuilder(
                                                      builder: (context,
                                                          StateSetter
                                                              setState) {
                                                    return Container(
                                                      height: 260,
                                                      color: Colors.white,
                                                      child: Center(
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          children: <Widget>[
                                                            const SizedBox(
                                                              height: 18,
                                                            ),
                                                            Text(
                                                              'Your post can be buzzed',
                                                              style: TextStyle(
                                                                fontSize: 16.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                    .black,
                                                              ),
                                                            ),

                                                            SizedBox(
                                                              height: 18.h,
                                                            ),
                                                            // Toggle button
                                                            Transform.scale(
                                                              scale: 0.9,
                                                              child:
                                                                  CupertinoSwitch(
                                                                value:
                                                                    _switchValue,
                                                                onChanged:
                                                                    (value) {
                                                                  setState(() {
                                                                    _switchValue =
                                                                        value;
                                                                  });
                                                                  if (_switchValue ==
                                                                      true) {
                                                                    setState(
                                                                        () {
                                                                      selectedPostType =
                                                                          "Post & Buzz";
                                                                    });
                                                                  } else {
                                                                    setState(
                                                                        () {
                                                                      selectedPostType =
                                                                          "Post";
                                                                    });
                                                                  }
                                                                },
                                                              ),
                                                            ),

                                                            Text(
                                                                "$selectedPostType"),

                                                            SizedBox(
                                                              height: 20.h,
                                                            ),
                                                            CustomButton(
                                                              width: 235,
                                                              height: 50,
                                                              isBlue: false,
                                                              isRed: false,
                                                              radius: 60,
                                                              buttonText:
                                                                  'Next',
                                                              customStyle: true,
                                                              styleText:
                                                                  TextStyle(
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                              onTap: () {
                                                                setState(() {
                                                                  _switchValue =
                                                                      false;
                                                                });
                                                                Navigator.pop(
                                                                    context);
                                                                selectedPostType ==
                                                                        "Post & Buzz"
                                                                    ? setState(
                                                                        () {
                                                                        showModalBottomSheet<
                                                                            void>(
                                                                          context:
                                                                              context,
                                                                          builder:
                                                                              (BuildContext context) {
                                                                            return Container(
                                                                              height: 260,
                                                                              color: Colors.white,
                                                                              child: Center(
                                                                                child: Column(
                                                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                                                  mainAxisSize: MainAxisSize.min,
                                                                                  children: <Widget>[
                                                                                    const SizedBox(
                                                                                      height: 18,
                                                                                    ),
                                                                                    Row(
                                                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                                                      children: [
                                                                                        Text(
                                                                                          'Start a buzz',
                                                                                          style: TextStyle(
                                                                                            fontSize: 16.sp,
                                                                                          ),
                                                                                        ),
                                                                                        SizedBox(
                                                                                          width: 4.w,
                                                                                        ),
                                                                                        Text(
                                                                                          'Choose from : -->',
                                                                                          style: TextStyle(
                                                                                            fontSize: 16.sp,
                                                                                            fontWeight: FontWeight.bold,
                                                                                            color: Colors.black,
                                                                                          ),
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                    SizedBox(
                                                                                      height: 18.h,
                                                                                    ),
                                                                                    InkWell(
                                                                                      child: Container(
                                                                                        width: 160.w,
                                                                                        padding: const EdgeInsets.symmetric(vertical: 10),
                                                                                        decoration: const BoxDecoration(
                                                                                          color: Colors.green,
                                                                                          borderRadius: BorderRadius.all(Radius.circular(28)),
                                                                                          boxShadow: [
                                                                                            BoxShadow(
                                                                                              color: Colors.grey,
                                                                                              blurRadius: 6,
                                                                                            ),
                                                                                          ],
                                                                                        ),
                                                                                        child: Row(
                                                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                                                          children: const [
                                                                                            SizedBox(
                                                                                              height: 30,
                                                                                              child: Padding(
                                                                                                padding: EdgeInsets.all(4.0),
                                                                                                child: Icon(
                                                                                                  Icons.photo_library,
                                                                                                  color: Colors.white,
                                                                                                ),
                                                                                              ),
                                                                                            ),
                                                                                            SizedBox(
                                                                                              width: 14,
                                                                                            ),
                                                                                            Text(
                                                                                              "Gallery",
                                                                                              style: TextStyle(
                                                                                                fontSize: 20,
                                                                                                fontWeight: FontWeight.bold,
                                                                                                color: Colors.white,
                                                                                              ),
                                                                                            )
                                                                                          ],
                                                                                        ),
                                                                                      ),
                                                                                      onTap: () {
                                                                                        _openImagePicker(ImageSource.gallery);
                                                                                      },
                                                                                    ),
                                                                                    SizedBox(
                                                                                      height: 20.h,
                                                                                    ),
                                                                                    InkWell(
                                                                                      child: Container(
                                                                                        width: 160.w,
                                                                                        padding: const EdgeInsets.symmetric(vertical: 10),
                                                                                        decoration: const BoxDecoration(
                                                                                          color: Colors.green,
                                                                                          borderRadius: BorderRadius.all(Radius.circular(28)),
                                                                                          boxShadow: [
                                                                                            BoxShadow(
                                                                                              color: Colors.grey,
                                                                                              blurRadius: 6,
                                                                                            ),
                                                                                          ],
                                                                                        ),
                                                                                        child: Row(
                                                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                                                          children: const [
                                                                                            SizedBox(
                                                                                              height: 30,
                                                                                              child: Padding(
                                                                                                padding: EdgeInsets.all(4.0),
                                                                                                child: Icon(
                                                                                                  Icons.photo_camera,
                                                                                                  color: Colors.white,
                                                                                                ),
                                                                                              ),
                                                                                            ),
                                                                                            SizedBox(
                                                                                              width: 14,
                                                                                            ),
                                                                                            Text(
                                                                                              "Camera",
                                                                                              style: TextStyle(
                                                                                                fontSize: 20,
                                                                                                fontWeight: FontWeight.bold,
                                                                                                color: Colors.white,
                                                                                              ),
                                                                                            )
                                                                                          ],
                                                                                        ),
                                                                                      ),
                                                                                      onTap: () {
                                                                                        _openImagePicker(ImageSource.camera);
                                                                                      },
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                            );
                                                                          },
                                                                        );
                                                                        _openTimePickerSheet(
                                                                            context);
                                                                      })
                                                                    : showModalBottomSheet<
                                                                        void>(
                                                                        context:
                                                                            context,
                                                                        builder:
                                                                            (BuildContext
                                                                                context) {
                                                                          return Container(
                                                                            height:
                                                                                260,
                                                                            color:
                                                                                Colors.white,
                                                                            child:
                                                                                Center(
                                                                              child: Column(
                                                                                mainAxisAlignment: MainAxisAlignment.center,
                                                                                mainAxisSize: MainAxisSize.min,
                                                                                children: <Widget>[
                                                                                  const SizedBox(
                                                                                    height: 18,
                                                                                  ),
                                                                                  Row(
                                                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                                                    children: [
                                                                                      Text(
                                                                                        'Start a buzz',
                                                                                        style: TextStyle(
                                                                                          fontSize: 16.sp,
                                                                                        ),
                                                                                      ),
                                                                                      SizedBox(
                                                                                        width: 4.w,
                                                                                      ),
                                                                                      Text(
                                                                                        'Choose from : -->',
                                                                                        style: TextStyle(
                                                                                          fontSize: 16.sp,
                                                                                          fontWeight: FontWeight.bold,
                                                                                          color: Colors.black,
                                                                                        ),
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                  SizedBox(
                                                                                    height: 18.h,
                                                                                  ),
                                                                                  InkWell(
                                                                                    child: Container(
                                                                                      width: 160.w,
                                                                                      padding: const EdgeInsets.symmetric(vertical: 10),
                                                                                      decoration: const BoxDecoration(
                                                                                        color: Colors.green,
                                                                                        borderRadius: BorderRadius.all(Radius.circular(28)),
                                                                                        boxShadow: [
                                                                                          BoxShadow(
                                                                                            color: Colors.grey,
                                                                                            blurRadius: 6,
                                                                                          ),
                                                                                        ],
                                                                                      ),
                                                                                      child: Row(
                                                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                                                        children: const [
                                                                                          SizedBox(
                                                                                            height: 30,
                                                                                            child: Padding(
                                                                                              padding: EdgeInsets.all(4.0),
                                                                                              child: Icon(
                                                                                                Icons.photo_library,
                                                                                                color: Colors.white,
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                          SizedBox(
                                                                                            width: 14,
                                                                                          ),
                                                                                          Text(
                                                                                            "Gallery",
                                                                                            style: TextStyle(
                                                                                              fontSize: 20,
                                                                                              fontWeight: FontWeight.bold,
                                                                                              color: Colors.white,
                                                                                            ),
                                                                                          )
                                                                                        ],
                                                                                      ),
                                                                                    ),
                                                                                    onTap: () {
                                                                                      _openImagePicker(ImageSource.gallery);
                                                                                    },
                                                                                  ),
                                                                                  SizedBox(
                                                                                    height: 20.h,
                                                                                  ),
                                                                                  InkWell(
                                                                                    child: Container(
                                                                                      width: 160.w,
                                                                                      padding: const EdgeInsets.symmetric(vertical: 10),
                                                                                      decoration: const BoxDecoration(
                                                                                        color: Colors.green,
                                                                                        borderRadius: BorderRadius.all(Radius.circular(28)),
                                                                                        boxShadow: [
                                                                                          BoxShadow(
                                                                                            color: Colors.grey,
                                                                                            blurRadius: 6,
                                                                                          ),
                                                                                        ],
                                                                                      ),
                                                                                      child: Row(
                                                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                                                        children: const [
                                                                                          SizedBox(
                                                                                            height: 30,
                                                                                            child: Padding(
                                                                                              padding: EdgeInsets.all(4.0),
                                                                                              child: Icon(
                                                                                                Icons.photo_camera,
                                                                                                color: Colors.white,
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                          SizedBox(
                                                                                            width: 14,
                                                                                          ),
                                                                                          Text(
                                                                                            "Camera",
                                                                                            style: TextStyle(
                                                                                              fontSize: 20,
                                                                                              fontWeight: FontWeight.bold,
                                                                                              color: Colors.white,
                                                                                            ),
                                                                                          )
                                                                                        ],
                                                                                      ),
                                                                                    ),
                                                                                    onTap: () {
                                                                                      _openImagePicker(ImageSource.camera);
                                                                                    },
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                          );
                                                                        },
                                                                      );
                                                                // :
                                                                // // Post & Buzz
                                                                // showModalBottomSheet<
                                                                //     void>(
                                                                //     context:
                                                                //         context,
                                                                //     builder:
                                                                //         (BuildContext
                                                                //             context) {
                                                                //       return StatefulBuilder(builder:
                                                                //           (context, StateSetter setState) {
                                                                //         return Container(
                                                                //           height: 260,
                                                                //           color: Colors.white,
                                                                //           child: Center(
                                                                //             child: Column(
                                                                //               mainAxisAlignment: MainAxisAlignment.center,
                                                                //               mainAxisSize: MainAxisSize.min,
                                                                //               children: <Widget>[
                                                                //                 const SizedBox(
                                                                //                   height: 18,
                                                                //                 ),
                                                                //                 Center(
                                                                //                   child: SizedBox(
                                                                //                     width: 300.w,
                                                                //                     child: Text(
                                                                //                       'Select Time Limit upto which your post can be buzzed',
                                                                //                       textAlign: TextAlign.center,
                                                                //                       style: TextStyle(
                                                                //                         fontSize: 16.sp,
                                                                //                         fontWeight: FontWeight.bold,
                                                                //                         color: Colors.black,
                                                                //                       ),
                                                                //                     ),
                                                                //                   ),
                                                                //                 ),

                                                                //                 SizedBox(
                                                                //                   height: 18.h,
                                                                //                 ),
                                                                //                 //
                                                                //                 InkWell(
                                                                //                     onTap: () {
                                                                //                       setState(() {
                                                                //                         _openTimePickerSheet(context);
                                                                //                       });
                                                                //                     },
                                                                //                     child: Container(
                                                                //                       height: 50.h,
                                                                //                       width: 50.w,
                                                                //                       child: Text(
                                                                //                         'Choose Time',
                                                                //                         style: TextStyle(color: Colors.red),
                                                                //                       ),
                                                                //                     )),

                                                                //                 SizedBox(
                                                                //                   height: 20.h,
                                                                //                 ),
                                                                //                 CustomButton(
                                                                //                   width: 235,
                                                                //                   height: 50,
                                                                //                   isBlue: false,
                                                                //                   isRed: false,
                                                                //                   radius: 60,
                                                                //                   buttonText: 'Next',
                                                                //                   customStyle: true,
                                                                //                   styleText: TextStyle(
                                                                //                     color: Colors.white,
                                                                //                   ),
                                                                //                   onTap: () {},
                                                                //                   requireIcon: false,
                                                                //                   isSvg: false,
                                                                //                   prefixIcon: false,
                                                                //                   buttonClicked: false,
                                                                //                   prefixIconImage: '',
                                                                //                   isTransparent: false,
                                                                //                 ),
                                                                //               ],
                                                                //             ),
                                                                //           ),
                                                                //         );
                                                                //       });
                                                                //     },
                                                                //   );
                                                              },
                                                              requireIcon:
                                                                  false,
                                                              isSvg: false,
                                                              prefixIcon: false,
                                                              buttonClicked:
                                                                  false,
                                                              prefixIconImage:
                                                                  '',
                                                              isTransparent:
                                                                  false,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    );
                                                  });
                                                },
                                              );
                                            }
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
          label: const Text(
            'Start a Buzz',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          icon: Container(
            padding: const EdgeInsets.all(2),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(16)),
            ),
            child: Image.asset(
              'assets/buzzadd.png',
              width: 26.w,
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      //Buttom_Navbar
      bottomNavigationBar: BottomAppBar(
        color: themeColor.withOpacity(0.95),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 18),
              child: IconButton(
                onPressed: () {},
                icon: Image.asset(
                  'assets/home solid.png',
                  width: 28.w,
                  color: Colors.white,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 18),
              child: IconButton(
                onPressed: () {
                  db.put('userLoggedIn', false);
                  log('User Logged out');
                },
                icon: Image.asset(
                  'assets/globe3.gif',
                  width: 28.w,
                ),
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: loadData
            ? Column(
                children: [
                  SizedBox(
                    height: 300.h,
                  ),
                  Center(
                      child: CircularProgressIndicator(
                    color: Colors.yellowAccent,
                  )),
                ],
              )
            : Column(
                children: [
                  db.get('allPost') == null
                      ? Column(
                          children: [
                            SizedBox(
                              height: 300.h,
                            ),
                            Center(
                              child: Text(
                                'Welcome to NameBuzz',
                                style: TextStyle(
                                  fontSize: 24.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        )
                      :
                      // Storis showing section ***************************************

                      //1st Post ******************************************************
                      Container(
                          padding: const EdgeInsets.only(bottom: 8),
                          margin: const EdgeInsets.only(top: 10),
                          //color: Colors.white,
                          child: Column(
                            children: [
                              //1st section

                              // 2nd section
                              SizedBox(
                                width: double.infinity,
                                child: ListView.builder(
                                    shrinkWrap: true,
                                    physics: const BouncingScrollPhysics(),
                                    // itemCount:
                                    //     allPostsFromServer['posts'].length,
                                    itemCount: allPosts.length,
                                    itemBuilder: (context, index) {
                                      selectedCategory = mapCategoryList.entries
                                          .firstWhere((entry) =>
                                              entry.value ==
                                              allPosts[index]['category'])
                                          // allPostsFromServer['posts'][index]
                                          //     ['catego'])
                                          .key;
                                      log('message as $selectedCategory');
                                      return Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 15.0),
                                        child: Container(
                                          color: Colors.white,
                                          child: Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Row(
                                                    children: [
                                                      SizedBox(
                                                        width: 10.w,
                                                      ),
                                                      Container(
                                                        child: allPosts
                                                                .isNotEmpty
                                                            ? CircleAvatar(
                                                                child: Image.asset(
                                                                    "$selectedCategory"),
                                                              )
                                                            : IconButton(
                                                                onPressed:
                                                                    () {},
                                                                icon: const Icon(
                                                                    Icons
                                                                        .photo_camera),
                                                                iconSize: 20,
                                                              ),
                                                      ),
                                                      SizedBox(
                                                        width: 10.w,
                                                      ),
                                                      Container(
                                                        child: Text(
                                                          allPostsFromServer['posts']
                                                                          [
                                                                          index]
                                                                      [
                                                                      'title'] ==
                                                                  null
                                                              ? " "
                                                              : '${allPostsFromServer['posts'][index]['title']}',
                                                          style: TextStyle(
                                                            fontSize: 14,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  IconButton(
                                                    onPressed: () {},
                                                    icon: const Icon(
                                                        Icons.more_vert),
                                                    iconSize: 20,
                                                  ),
                                                ],
                                              ),
                                              const Divider(
                                                thickness: 1,
                                                color: Colors.black,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Container(
                                                        child: IconButton(
                                                          onPressed: () {},
                                                          icon:
                                                              const CircleAvatar(
                                                            backgroundImage:
                                                                AssetImage(
                                                                    'assets/buzz-logo.png'),
                                                            backgroundColor:
                                                                Colors
                                                                    .transparent,
                                                          ),
                                                        ),
                                                      ),
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 6),
                                                            child: Row(
                                                              children: const [
                                                                Text(
                                                                  'Namebuzz',
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        16,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding: EdgeInsets
                                                                      .only(
                                                                          left:
                                                                              6),
                                                                  child: Icon(
                                                                    Icons
                                                                        .verified,
                                                                    size: 18,
                                                                    color: Color(
                                                                        0XFFFFC312),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          const Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    left: 6),
                                                            child: Text(
                                                              '1m ago',
                                                              style: TextStyle(
                                                                fontSize: 12,
                                                              ),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text(
                                                        // 'This is post title. This is post title. This is post title. This is post title. This is post title. This is post title',
                                                        '${allPosts[index]['buzzTimeSelected']}',
                                                        style: const TextStyle(
                                                            fontSize: 14,
                                                            color: Colors.blue
                                                            // fontFamily: 'Roboto',
                                                            ),
                                                      ),
                                                      IconButton(
                                                        onPressed: () {},
                                                        icon: const Icon(Icons
                                                            .bookmark_outline),
                                                        iconSize: 22,
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              // 3rd section
                                              Container(
                                                margin: const EdgeInsets.all(6),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              bottom: 8),
                                                      child: Text(
                                                        // 'This is post title. This is post title. This is post title. This is post title. This is post title. This is post title',
                                                        '${allPosts[index]['caption']}',
                                                        style: const TextStyle(
                                                          fontSize: 14,
                                                          // fontFamily: 'Roboto',
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              bottom: 8),
                                                      child: Text(
                                                        // 'This is post title. This is post title. This is post title. This is post title. This is post title. This is post title',
                                                        '${allPosts[index]['hashtags']}',
                                                        style: const TextStyle(
                                                            fontSize: 14,
                                                            color: Colors.blue
                                                            // fontFamily: 'Roboto',
                                                            ),
                                                      ),
                                                    ),
                                                    allPosts.isEmpty
                                                        ? const Image(
                                                            image: AssetImage(
                                                                'assets/1.jpg'))
                                                        // : Image.file(postedImage),
                                                        : Image.network(
                                                            '${allPostsFromServer['posts'][index]['url']}'),
                                                    // : Image.memory(
                                                    //     allPosts[index]
                                                    //         ['image']),
                                                  ],
                                                ),
                                              ),
                                              //

                                              // 4th section
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  InkWell(
                                                    child: Container(
                                                      height: 24.h,
                                                      width: 24.w,
                                                      decoration:
                                                          const BoxDecoration(
                                                        image: DecorationImage(
                                                          image: AssetImage(
                                                              'assets/buzzpost.png'),
                                                        ),
                                                      ),
                                                    ),
                                                    onTap: () {},
                                                  ),
                                                  IconButton(
                                                      onPressed: () {},
                                                      icon: const Icon(Icons
                                                          .favorite_outline)),
                                                  IconButton(
                                                      onPressed: () {},
                                                      icon: const Icon(Icons
                                                          .forum_outlined)),
                                                  IconButton(
                                                      onPressed: () {},
                                                      icon: const Icon(Icons
                                                          .comment_outlined)),
                                                  IconButton(
                                                      onPressed: () {},
                                                      icon: const Icon(Icons
                                                          .share_outlined)),
                                                ],
                                              ),
                                              // 5th section
                                              Row(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 18),
                                                    child: Text(
                                                      '14K',
                                                      style: TextStyle(
                                                        fontSize: 14.sp,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: const Color(
                                                            0XFFFFC312),
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 2,
                                                  ),
                                                  const Text(
                                                    'Likes',
                                                    style:
                                                        TextStyle(fontSize: 14),
                                                  )
                                                ],
                                              ),
                                              // 6th section
                                              const SizedBox(
                                                height: 4,
                                              ),
                                              // 7th section
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 12),
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                          'Prashant',
                                                          style: TextStyle(
                                                              fontSize: 10.sp),
                                                        ),
                                                        SizedBox(
                                                          width: 1.w,
                                                        ),
                                                        Text('and',
                                                            style: TextStyle(
                                                                fontSize:
                                                                    10.sp)),
                                                        SizedBox(
                                                          width: 1.w,
                                                        ),
                                                        Text('55',
                                                            style: TextStyle(
                                                              fontSize: 10.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            )),
                                                        SizedBox(
                                                          width: 1.w,
                                                        ),
                                                        Text('others comment',
                                                            style: TextStyle(
                                                                fontSize:
                                                                    10.sp)),
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                            right: 14),
                                                    child: Row(
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  right: 4),
                                                          child: SizedBox(
                                                            height: 18.h,
                                                            width: 18.w,
                                                            child: Image.asset(
                                                                'assets/buzzadd.png'),
                                                          ),
                                                        ),
                                                        Text(
                                                          '20',
                                                          style: TextStyle(
                                                            fontSize: 10.sp,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: 2.w,
                                                        ),
                                                        Text(
                                                          'people have buzz on this',
                                                          style: TextStyle(
                                                              fontSize: 10.sp),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    }),
                              )
                            ],
                          ),
                        ),
                  // Main column children
                ],
              ),
      ),
    );
  }
}



*/