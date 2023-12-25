import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shop_app/bloc/Auth/auth_cubit.dart';
import 'package:shop_app/bloc/Auth/auth_state.dart';
import 'package:shop_app/core/Utils/Widgets/custom_appbar.dart';
import 'package:shop_app/core/Utils/Widgets/custom_button.dart';

import '../../Repo/auth_repo.dart';
import '../../models/usermodel.dart';
import '../home_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
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
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
              child: (state is AuthLoggedInState)
                  ? Column(
                      children: [
                        CustomAppBar(title: 'Profile', applyleading: false),
                        CircleAvatar(
                          backgroundColor:
                              Colors.deepPurpleAccent.withOpacity(0.6),
                          radius: 40.r,
                          backgroundImage:
                              NetworkImage("userModel!.profilepic.toString()"),
                          child: Icon(
                              color: Colors.white, size: 40.w, Icons.person),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Text(
                          state.userModel.name.toString(),
                          style: GoogleFonts.montserrat(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                            color: Colors.black.withOpacity(0.7),
                          ),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Container(
                          height: 40.h,
                          width: double.infinity,
                          margin: EdgeInsets.symmetric(horizontal: 19.w),
                          padding: EdgeInsets.symmetric(horizontal: 19.w),
                          decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.04),
                              borderRadius: BorderRadius.circular(10.r)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                state.userModel.name.toString(),
                                style: GoogleFonts.montserrat(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black.withOpacity(0.7),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Container(
                          height: 40.h,
                          width: double.infinity,
                          margin: EdgeInsets.symmetric(horizontal: 19.w),
                          padding: EdgeInsets.symmetric(horizontal: 19.w),
                          decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.04),
                              borderRadius: BorderRadius.circular(10.r)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                state.userModel.email.toString(),
                                style: GoogleFonts.montserrat(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black.withOpacity(0.7),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Container(
                          height: 40.h,
                          width: double.infinity,
                          margin: EdgeInsets.symmetric(horizontal: 19.w),
                          padding: EdgeInsets.symmetric(horizontal: 19.w),
                          decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.04),
                              borderRadius: BorderRadius.circular(10.r)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "03292498892",
                                style: GoogleFonts.montserrat(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black.withOpacity(0.7),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Container(
                          height: 40.h,
                          width: double.infinity,
                          margin: EdgeInsets.symmetric(horizontal: 19.w),
                          padding: EdgeInsets.symmetric(horizontal: 19.w),
                          decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.04),
                              borderRadius: BorderRadius.circular(10.r)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Dera Ismail Khan",
                                style: GoogleFonts.montserrat(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black.withOpacity(0.7),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20.h,
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
                    )
                  : Center(
                      child: CircularProgressIndicator(),
                    )),
        );
      },
    );
  }
}
