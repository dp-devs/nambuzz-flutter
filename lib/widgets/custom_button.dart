import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

typedef OnPressedCallback = Function();

class CustomButton extends StatefulWidget {
  const CustomButton({
    Key? key,
    required this.width,
    required this.height,
    required this.isBlue,
    required this.isRed,
    required this.radius,
    required this.buttonText,
    required this.customStyle,
    required this.styleText,
    required this.onTap,
    required this.requireIcon,
    required this.isSvg,
    required this.prefixIcon,
    required this.buttonClicked,
    required this.prefixIconImage,
    required this.isTransparent,
  }) : super(key: key);

  final double width;
  final double height;
  final double radius;
  final bool requireIcon;
  final bool prefixIcon;
  final bool customStyle;
  final bool isBlue;
  final bool isRed;
  final bool isSvg;
  final bool isTransparent;
  final bool buttonClicked;
  final String buttonText;
  final TextStyle styleText;
  final Function onTap;
  final String prefixIconImage;

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  bool themeIsDark = false;

  @override
  Widget build(BuildContext context) {
    final double deviceHeight = MediaQuery.of(context).size.height;
    return themeIsDark
        ? InkWell(
            onTap: widget.buttonClicked
                ? null
                : () {
                    HapticFeedback.lightImpact();
                    widget.onTap();
                  },
            child: Container(
              width: widget.width.w,
              height: widget.height.h,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(widget.radius.r),
                  color: Colors.teal,
                  border: Border.all(color: Colors.green)),
              child: widget.requireIcon
                  ? widget.prefixIcon
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(widget.prefixIconImage),
                            SizedBox(
                              width: 13.w,
                            ),
                            Text(
                              widget.buttonText,
                              style: widget.styleText,
                            ),
                          ],
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              widget.buttonText,
                              style: widget.styleText,
                            ),
                            SizedBox(
                              width: 13.w,
                            ),
                            Image.asset(widget.prefixIconImage),
                          ],
                        )
                  : Center(
                      child: widget.buttonClicked
                          ? const CircularProgressIndicator(
                              strokeWidth: 3, color: Colors.black)
                          : Text(
                              widget.buttonText,
                              style: widget.customStyle
                                  ? widget.styleText
                                  : TextStyle(
                                      color: Colors.green,
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.w700),
                            ),
                    ),
            ),
          )
        : InkWell(
            onTap: widget.buttonClicked
                ? null
                : () {
                    HapticFeedback.lightImpact();
                    widget.onTap();
                  },
            child: Container(
              width: widget.width.w,
              height:
                  deviceHeight < 600 ? widget.height.h * 1.2 : widget.height.h,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(widget.radius.r),
                  color: Colors.red,
                  border: Border.all(color: Colors.orange)),
              child: widget.requireIcon
                  ? widget.prefixIcon
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(widget.prefixIconImage),
                            SizedBox(
                              width: 13.w,
                            ),
                            Text(
                              widget.buttonText,
                              style: widget.styleText,
                            ),
                          ],
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              widget.buttonText,
                              style: widget.styleText,
                            ),
                            SizedBox(
                              width: 13.w,
                            ),
                            Image.asset(widget.prefixIconImage),
                          ],
                        )
                  : Center(
                      child: widget.buttonClicked
                          ? const CircularProgressIndicator(
                              strokeWidth: 3, color: Colors.pink)
                          : Text(
                              widget.buttonText,
                              style: widget.customStyle
                                  ? widget.styleText
                                  : TextStyle(
                                      color: widget.isBlue || widget.isRed
                                          ? Colors.white
                                          : Colors.black,
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.w700),
                            ),
                    ),
            ),
          );
  }
}
