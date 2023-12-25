// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shop_app/core/Utils/sharedpref_helper.dart';
import 'package:shop_app/core/views/Auth/login_screen.dart';
import 'package:shop_app/core/views/Auth/profile_screen.dart';
import 'package:shop_app/core/views/cart_screen.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({
    super.key,
  });

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              DrawerHeader(
                child: Column(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.deepPurpleAccent.withOpacity(0.6),
                      radius: 40.r,
                      backgroundImage:
                          NetworkImage("userModel!.profilepic.toString()"),
                      child:
                          Icon(color: Colors.white, size: 40.w, Icons.person),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Text(
                      "Abdul Muhaimin",
                      style: GoogleFonts.montserrat(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.black.withOpacity(0.7),
                      ),
                    )
                  ],
                ),
              ),
              const Divider(
                color: Colors.black38,
              ),

              DrawerList(
                title: 'Profile',
                onTap: () async {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProfileScreen(),
                      ));
                },
              ),
              const Divider(
                color: Colors.black38,
              ),

              DrawerList(
                title: 'Track Orders',
                //svgsrc: friendsIcon,
                onTap: () {},
              ),
              const Divider(
                color: Colors.black38,
              ),
              DrawerList(
                title: 'Cart',
                onTap: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CartScreen(),
                      ));
                },
              ),
              const Divider(
                color: Colors.black38,
              ),

              DrawerList(
                title: 'Logout',
                onTap: () {
                  FirebaseAuth.instance.signOut();
                  SharedPreferenceHelper.logout();
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginScreen(),
                      ));
                },
              ),
              const Divider(
                color: Colors.black38,
              ),
              //Leaves
            ],
          ),
        ),
      ),
    );
  }
}

class DrawerList extends StatelessWidget {
  const DrawerList({
    super.key,
    required this.title,
    required this.onTap,
    //required this.svgsrc,
  });
  final String title;
  // final String //svgsrc;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 22.0.w),
      child: ListTile(
        onTap: onTap,
        // leading: SvgPicture.asset(
        //   //svgsrc,
        //   height: 22.h,
        //   color: AppColor.appColor,
        // ),
        title: Text(
          title,
          style: GoogleFonts.montserrat(
            fontSize: 12.sp,
            fontWeight: FontWeight.w500,
            color: Colors.black.withOpacity(0.7),
          ),
        ),
      ),
    );
  }
}
