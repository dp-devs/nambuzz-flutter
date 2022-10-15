import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0XFFf6e58d),
      // AppBar
      appBar: AppBar(
        backgroundColor: Color(0XFFFFC312),
        leading: IconButton(
          onPressed: () {},
          icon: CircleAvatar(
            backgroundColor: Colors.transparent,
            backgroundImage: AssetImage('assets/7.jpg'),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.military_tech,
            ),
            iconSize: 26,
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.group),
            iconSize: 24,
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.send,
            ),
            iconSize: 24,
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.notifications,
            ),
            iconSize: 24,
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
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
            backgroundColor: Color(0XFFf9ca24),
            extendedSizeConstraints:
                BoxConstraints.tightFor(width: 138.w, height: 40.h),
          ),
        ),
        child: FloatingActionButton.extended(
          onPressed: () {},
          label: Text(
            'Start a Buzz',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          icon: Container(
            padding: EdgeInsets.all(2),
            decoration: BoxDecoration(
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
        color: Color(0XFFFFC312),
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
                onPressed: () {},
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
        child: Column(
          children: [
            //1st Post ******************************************************
            Container(
              padding: EdgeInsets.only(bottom: 8),
              margin: EdgeInsets.only(top: 10),
              color: Colors.white,
              child: Column(
                children: [
                  //1st section
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            child: IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.photo_camera),
                              iconSize: 20,
                            ),
                          ),
                          Container(
                            child: Text(
                              'Travel',
                              style: TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ],
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.more_vert),
                        iconSize: 20,
                      ),
                    ],
                  ),
                  Divider(
                    thickness: 1,
                    color: Colors.black,
                  ),
                  // 2nd section
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            child: IconButton(
                              onPressed: () {},
                              icon: CircleAvatar(
                                backgroundImage:
                                    AssetImage('assets/buzz-logo.png'),
                                backgroundColor: Colors.transparent,
                              ),
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 6),
                                child: Row(
                                  children: [
                                    Text(
                                      'Namebuzz',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 6),
                                      child: Icon(
                                        Icons.verified,
                                        size: 18,
                                        color: Color(0XFFFFC312),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 6),
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
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.bookmark_outline),
                        iconSize: 22,
                      ),
                    ],
                  ),
                  // 3rd section
                  Container(
                    margin: EdgeInsets.all(6),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Text(
                            'This is post title. This is post title. This is post title. This is post title. This is post title. This is post title',
                            style: TextStyle(
                              fontSize: 14,
                              // fontFamily: 'Roboto',
                            ),
                          ),
                        ),
                        Image(image: AssetImage('assets/1.jpg')),
                      ],
                    ),
                  ),
                  // 4th section
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      InkWell(
                        child: Container(
                          height: 24.h,
                          width: 24.w,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/buzzpost.png'),
                            ),
                          ),
                        ),
                        onTap: () {},
                      ),
                      IconButton(
                          onPressed: () {}, icon: Icon(Icons.favorite_outline)),
                      IconButton(
                          onPressed: () {}, icon: Icon(Icons.forum_outlined)),
                      IconButton(
                          onPressed: () {}, icon: Icon(Icons.comment_outlined)),
                      IconButton(
                          onPressed: () {}, icon: Icon(Icons.share_outlined)),
                    ],
                  ),
                  // 5th section
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 18),
                        child: Text(
                          '14K',
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                            color: Color(0XFFFFC312),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 2,
                      ),
                      Text(
                        'Likes',
                        style: TextStyle(fontSize: 14),
                      )
                    ],
                  ),
                  // 6th section
                  SizedBox(
                    height: 4,
                  ),
                  // 7th section
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 12),
                        child: Row(
                          children: [
                            Text(
                              'Prashant',
                              style: TextStyle(fontSize: 10.sp),
                            ),
                            SizedBox(
                              width: 1.w,
                            ),
                            Text('and', style: TextStyle(fontSize: 10.sp)),
                            SizedBox(
                              width: 1.w,
                            ),
                            Text('55',
                                style: TextStyle(
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.bold,
                                )),
                            SizedBox(
                              width: 1.w,
                            ),
                            Text('others comment',
                                style: TextStyle(fontSize: 10.sp)),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(right: 14),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 4),
                              child: Container(
                                height: 18.h,
                                width: 18.w,
                                child: Image.asset('assets/buzzadd.png'),
                              ),
                            ),
                            Text(
                              '20',
                              style: TextStyle(
                                fontSize: 10.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              width: 2.w,
                            ),
                            Text(
                              'people have buzz on this',
                              style: TextStyle(fontSize: 10.sp),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            //2nd Post ******************************************************
            Container(
              padding: EdgeInsets.only(bottom: 8),
              margin: EdgeInsets.only(top: 10),
              color: Colors.white,
              child: Column(
                children: [
                  //1st section
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            child: IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.photo_camera),
                              iconSize: 20,
                            ),
                          ),
                          Container(
                            child: Text(
                              'Travel',
                              style: TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ],
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.more_vert),
                        iconSize: 20,
                      ),
                    ],
                  ),
                  Divider(
                    thickness: 1,
                    color: Colors.black,
                  ),
                  // 2nd section
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            child: IconButton(
                              onPressed: () {},
                              icon: CircleAvatar(
                                backgroundImage:
                                    AssetImage('assets/buzz-logo.png'),
                                backgroundColor: Colors.transparent,
                              ),
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 6),
                                    child: Text(
                                      'Namebuzz',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 6),
                                    child: Icon(
                                      Icons.verified,
                                      size: 18,
                                      color: Color(0XFFFFC312),
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 6),
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
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.bookmark_outline),
                        iconSize: 22,
                      ),
                    ],
                  ),
                  // 3rd section
                  Container(
                    margin: EdgeInsets.all(6),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Text(
                            'This is post title. This is post title. This is post title. This is post title. This is post title. This is post title',
                            style: TextStyle(
                              fontSize: 14,
                              // fontFamily: 'Roboto',
                            ),
                          ),
                        ),
                        Image(image: AssetImage('assets/2.jpg')),
                      ],
                    ),
                  ),
                  // 4th section
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      InkWell(
                        child: Container(
                          height: 24.h,
                          width: 24.w,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/buzzpost.png'),
                            ),
                          ),
                        ),
                        onTap: () {},
                      ),
                      IconButton(
                          onPressed: () {}, icon: Icon(Icons.favorite_outline)),
                      IconButton(
                          onPressed: () {}, icon: Icon(Icons.forum_outlined)),
                      IconButton(
                          onPressed: () {}, icon: Icon(Icons.comment_outlined)),
                      IconButton(
                          onPressed: () {}, icon: Icon(Icons.share_outlined)),
                    ],
                  ),
                  // 5th section
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 18),
                        child: Text(
                          '14K',
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                            color: Color(0XFFFFC312),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 2,
                      ),
                      Text(
                        'Likes',
                        style: TextStyle(fontSize: 14),
                      )
                    ],
                  ),
                  // 6th section
                  SizedBox(
                    height: 4,
                  ),
                  // 7th section
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 12),
                        child: Row(
                          children: [
                            Text(
                              'Prashant',
                              style: TextStyle(fontSize: 10.sp),
                            ),
                            SizedBox(
                              width: 1.w,
                            ),
                            Text('and', style: TextStyle(fontSize: 10.sp)),
                            SizedBox(
                              width: 1.w,
                            ),
                            Text('55',
                                style: TextStyle(
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.bold,
                                )),
                            SizedBox(
                              width: 1.w,
                            ),
                            Text('others comment',
                                style: TextStyle(fontSize: 10.sp)),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(right: 14),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 4),
                              child: Container(
                                height: 18.h,
                                width: 18.w,
                                child: Image.asset('assets/buzzadd.png'),
                              ),
                            ),
                            Text(
                              '20',
                              style: TextStyle(
                                fontSize: 10.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              width: 2.w,
                            ),
                            Text(
                              'people have buzz on this',
                              style: TextStyle(fontSize: 10.sp),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
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
