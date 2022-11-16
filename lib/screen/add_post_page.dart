import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hashtagable/hashtagable.dart';
import 'package:hive/hive.dart';

import '../const/widget/custom_alert.dart';
import 'home.dart';

class AddPostPage extends StatefulWidget {
  const AddPostPage(
      {super.key, required this.image, required this.buzzTimeSelected});

  final Uint8List image;
  final DateTime buzzTimeSelected;

  @override
  State<AddPostPage> createState() => _AddPostPageState();
}

class _AddPostPageState extends State<AddPostPage> {
  TextEditingController title = TextEditingController();
  TextEditingController caption = TextEditingController();
  List<dynamic> posts = [];
  var db = Hive.box('profileDetails');

  List<Map> categoryList = [
    {"image": "assets/photography.png", "name": "Photography"},
    {"image": "assets/food.png", "name": "Food"},
    {"image": "assets/travel.png", "name": "Travel"},
    {"image": "assets/music.png", "name": "Music"},
    {"image": "assets/fashion.png", "name": "Fashion"},
    {"image": "assets/entertain.png", "name": "Entertainment"},
    {"image": "assets/fitness.png", "name": "Health and Fitness"},
    {"image": "assets/tech.png", "name": "Technology"},
    {"image": "assets/beauty.png", "name": "Beauty and Cosmetics"},
    {"image": "assets/sports.png", "name": "Sports"},
    {"image": "assets/art.png", "name": "Art"},
    {"image": "assets/event.png", "name": "Events"},
    {"image": "assets/news.png", "name": "News"},
    {"image": "assets/writing.png", "name": "Writing"},
    {"image": "assets/automobile.png", "name": "Automobiles"},
  ];

  String? _dropDownValue;
  TextEditingController hashTagController = TextEditingController();

  @override
  void initState() {
    if (posts.isEmpty) {
      posts = [];
    } else {
      posts = db.get('allPost');
    }
    hashTagController.text = "Add Hashtag";
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
                  onTap: () async {
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
                        'hashtags': hashTagController.text,
                        'category': _dropDownValue,
                        'buzzTimeSelected': widget.buzzTimeSelected.toString(),
                      });
                      //db.add(posts);

                      db.put('allPost', posts);
                      // dynamic response = await ApiService().postUpload(
                      //     widget.image,
                      //     title.text,
                      //     caption.text,
                      //     hashTagController.text,
                      //     _dropDownValue!);
                      // log('response as $response');
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
              // Hashtags
              Padding(
                padding: EdgeInsets.only(left: 15.0.w),
                child: HashTagTextField(
                  controller: hashTagController,
                  decoratedStyle:
                      TextStyle(fontSize: 18.sp, color: Colors.blue),
                  basicStyle: TextStyle(fontSize: 18.sp, color: Colors.white),
                ),
              ),
              SizedBox(
                height: 40.h,
              ),
              SizedBox(
                child: DropdownButtonHideUnderline(
                  child: ButtonTheme(
                    alignedDropdown: true,
                    child: DropdownButton<String>(
                      isDense: true,
                      isExpanded: true,
                      onChanged: (val) {
                        setState(() {
                          _dropDownValue = val!;
                        });
                      },
                      // value: _dropDownValue,
                      hint: _dropDownValue == null
                          ? Text(
                              "Select Category",
                              style: TextStyle(color: Colors.white),
                            )
                          : Text(
                              "$_dropDownValue",
                              style: TextStyle(color: Colors.white),
                            ),
                      style: TextStyle(color: Colors.white, fontSize: 18.sp),
                      icon: Icon(
                        Icons.arrow_drop_down,
                        color: Colors.blue,
                      ),
                      dropdownColor: Colors.grey,
                      items: categoryList.map((Map map) {
                        return new DropdownMenuItem<String>(
                          value: map["name"].toString(),
                          // value: _mySelection,
                          child: Row(
                            children: <Widget>[
                              Image.asset(
                                map["image"],
                                width: 25,
                              ),
                              Container(
                                  margin: EdgeInsets.only(left: 10),
                                  child: Text(map["name"])),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
