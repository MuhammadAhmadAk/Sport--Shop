import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shop_app/core/views/home_screen.dart';

import '../../Repo/auth_repo.dart';
import '../../Utils/Widgets/custom_button.dart';
import '../../models/usermodel.dart';

class PaymentSuccessView extends StatefulWidget {
  final String price;

  const PaymentSuccessView({
    Key? key,
    required this.price,
  }) : super(key: key);

  @override
  State<PaymentSuccessView> createState() => _PaymentSuccessViewState();
}

class _PaymentSuccessViewState extends State<PaymentSuccessView> {
  User? curUser = FirebaseAuth.instance.currentUser;
  UserModel? userModel;
  getUserModel() async {
    userModel = await AuthRepository.getUserbyId(curUser!.uid);
  }

  @override
  void initState() {
    super.initState();
    getUserModel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.check_circle,
                    color: Colors.deepPurpleAccent,
                    size: 100.0,
                  ),
                  SizedBox(height: 16.0.h),
                  Text(
                    "Payment Successful",
                    style: GoogleFonts.montserrat(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.black.withOpacity(0.7),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 26.h,
            ),
            Card(
              elevation: 0.0,
              margin: EdgeInsets.symmetric(horizontal: 45.w),
              shape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.black.withOpacity(0.1)),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Column(
                children: [
                  DetailText(
                    title: 'Price',
                    detail: 'Rs : ${widget.price}',
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 46.h,
            ),
            CustombuttonWidget(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomeScreen(
                        curUser: curUser,
                        userModel: userModel,
                      ),
                    ));
              },
              text: "Continoue",
              buttonHeight: 35.h,
              buttonBackgroundColor: Colors.deepPurpleAccent,
              buttonWidth: 260.w,
              fontSize: 13.sp,
              fontWeight: FontWeight.w400,
            )
          ],
        ),
      ),
    );
  }
}

class DetailText extends StatelessWidget {
  const DetailText({
    super.key,
    required this.title,
    required this.detail,
  });
  final String? title;
  final String? detail;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 17.0.w, vertical: 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              title ?? "Not Define",
              style: GoogleFonts.montserrat(
                  fontSize: 12, fontWeight: FontWeight.w500),
            ),
          ),
          Expanded(
            child: Text(
              detail ?? " ",
              style: GoogleFonts.montserrat(
                  fontSize: 12, fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }
}
