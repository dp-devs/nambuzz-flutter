import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:namebuzz/screen/home.dart';

import '../const/widget/custom_alert.dart';

class AddPostPage extends StatefulWidget {
  const AddPostPage({super.key, required this.image});

  final Uint8List image;

  @override
  State<AddPostPage> createState() => _AddPostPageState();
}

class _AddPostPageState extends State<AddPostPage> {
  TextEditingController title = TextEditingController();
  TextEditingController caption = TextEditingController();
  List<dynamic> posts = [];
  var db = Hive.box('profileDetails');

  @override
  void initState() {
    if (posts.isEmpty) {
      posts = [];
    } else {
      posts = db.get('allPost');
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black.withOpacity(0.8),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0.w),
          child: Column(
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      width: 16.w,
                    ),
                    const Text(
                      'Add Post',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    if (title.text.isEmpty) {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            Future.delayed(const Duration(milliseconds: 800),
                                () {
                              Navigator.of(context).pop(true);
                            });
                            return const CustomAlert(
                              alertTitle: 'Please Add Title',
                            );
                          });
                    } else if (caption.text.isEmpty) {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            Future.delayed(const Duration(milliseconds: 800),
                                () {
                              Navigator.of(context).pop(true);
                            });
                            return const CustomAlert(
                              alertTitle: 'Please Add Caption',
                            );
                          });
                    } else {
                      HapticFeedback.heavyImpact();
                      posts.add({
                        'userId': db.get('userId'),
                        'title': title.text,
                        'caption': caption.text,
                        'image': widget.image,
                      });
                      //db.add(posts);

                      db.put('allPost', posts);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const HomeScreen()));
                    }
                  },
                  child: const Text(
                    'Post',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ]),
              SizedBox(
                height: 40.h,
              ),
              Row(
                children: [
                  const CircleAvatar(),
                  SizedBox(
                    width: 20.w,
                  ),
                  Expanded(
                    child: TextField(
                      controller: title,
                      style: TextStyle(color: Colors.white, fontSize: 15.sp),
                      decoration: InputDecoration.collapsed(
                          hintText: 'Add Title',
                          hintStyle:
                              TextStyle(color: Colors.white, fontSize: 15.sp)),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 40.h,
              ),
              Row(
                children: [
                  SizedBox(
                      height: 50.h,
                      width: 50.w,
                      child: Image.memory(
                        widget.image,
                      )),
                  SizedBox(
                    width: 20.w,
                  ),
                  Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      width: 335.w,
                      child: Center(
                        child: TextField(
                          controller: caption,
                          style:
                              TextStyle(color: Colors.white, fontSize: 15.sp),
                          maxLines: 3,
                          decoration: InputDecoration(
                              counterText: '',
                              hintText: 'Be Specific to your post',
                              hintStyle: TextStyle(
                                  color: Colors.white, fontSize: 15.sp)),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 40.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
