import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomAlert extends StatelessWidget {
  const CustomAlert({Key? key, required this.alertTitle}) : super(key: key);

  final String alertTitle;

  dialogContent(BuildContext context) {
    return Container(
      width: 144.w,
      height: 46.h,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(114.r),
          color: Colors.black.withOpacity(0.5)),
      child: Center(
        child: Text(
          alertTitle,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16.0.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context),
    );
  }
}
