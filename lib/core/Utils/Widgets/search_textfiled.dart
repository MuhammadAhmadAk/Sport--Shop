import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchTextField extends StatelessWidget {
  const SearchTextField({
    Key? key,
    this.controller,
    this.onChanged,
    this.hintText,
    this.textFieldTheme,
  }) : super(key: key);

  final TextEditingController? controller;
  final void Function(String)? onChanged;
  final String? hintText;
  final TextStyle? textFieldTheme;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250.w,
      height: 35.h,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5.r),
      ),
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.text,
        onChanged: onChanged,
        style: textFieldTheme ??
            GoogleFonts.montserrat(
              fontSize: 15.sp,
              fontWeight: FontWeight.w500,
              color: Colors.black.withOpacity(0.5),
            ),
        cursorColor: Colors.grey.withOpacity(0.07),
        decoration: InputDecoration(
          prefixIcon: const Icon(
            Icons.search,
            color: Colors.deepPurpleAccent,
          ),
          contentPadding: EdgeInsets.all(10.w),
          hintText: hintText,
          fillColor: Colors.grey.withOpacity(0),
          filled: true,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.r),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.r),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
