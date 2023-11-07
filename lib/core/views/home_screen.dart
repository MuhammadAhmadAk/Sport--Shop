// ignore_for_file: use_build_context_synchronously

import 'package:category_navigator/category_navigator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shop_app/bloc/cart/cart_cubit.dart';
import 'package:shop_app/bloc/cart/cart_state.dart';
import 'package:shop_app/core/Utils/Widgets/custom_drawer.dart';
import 'package:shop_app/core/Utils/Widgets/search_textfiled.dart';
import 'package:shop_app/core/models/usermodel.dart';
import 'package:shop_app/core/views/all_products.dart';
import 'package:shop_app/core/views/cart_screen.dart';
import 'package:shop_app/core/views/cricket_screen.dart';
import 'package:shop_app/core/views/football_screen.dart';
import 'package:shop_app/core/views/hockey_screen.dart';

class HomeScreen extends StatefulWidget {
  final User? curUser;
  final UserModel? userModel;
  const HomeScreen({super.key, required this.curUser, required this.userModel});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> itemsList = const ['All', 'Cricket', 'Football', 'Hockey'];
  int selectedCategoryIndex = 0; // Initialize with the index of 'All'

  getcartItems() async {
    await context.read<CartCubit>().getAllCartItems();
  }

  @override
  void initState() {
    super.initState();
    getcartItems();
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
      key: _scaffoldKey,
      drawer: CustomDrawer(),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: 100.h,
              decoration: BoxDecoration(color: Colors.deepPurpleAccent),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 13.0.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      onTap: () {
                        _scaffoldKey.currentState!.openDrawer();
                      },
                      child: Image.asset(
                        'assets/images/menu.png',
                        height: 20.h,
                        color: Colors.white,
                      ),
                    ),
                    SearchTextField(
                      hintText: "Search",
                    ),
                    BlocBuilder<CartCubit, CartState>(
                      builder: (context, state) {
                        return GestureDetector(
                          onTap: () {
                            context.read<CartCubit>().getAllCartItems();
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CartScreen(),
                                ));
                          },
                          child: Badge(
                            label: (state is CartItemLoadedState)
                                ? Text(state.cartItems!.length.toString())
                                : const Text("0"),
                            child: Image.asset(
                              'assets/images/cart.png',
                              height: 24.h,
                              color: Colors.white,
                            ),
                          ),
                        );
                      },
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            CategoryNavigator(
              itemElevation: 0.0,
              unselectedBackgroundColor: Colors.white,
              navigatorBackgroundColor: Colors.white,
              highlightBackgroundColor: Colors.deepPurpleAccent,
              navigatorElevation: 1,
              expand: false,
              labels: itemsList,
              navigatorController: NavigatorController(),
              scrollController: ScrollController(),
              itemMargin: EdgeInsets.all(12.w),
              unselectedTextStyle: GoogleFonts.montserrat(
                fontSize: 12.sp,
                color: Colors.black,
              ),
              highlightTextStyle: GoogleFonts.montserrat(
                fontSize: 11.sp,
                color: Colors.white,
              ),
              itemPadding:
                  EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
              onChange: (activeIndex) {
                setState(() {
                  selectedCategoryIndex = activeIndex;
                });
              },
            ),
            Expanded(
              child: _buildContent(selectedCategoryIndex),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildContent(int selectedCategoryIndex) {
  // You can conditionally build the content based on the selected category index.
  // Implement the content for each category screen as needed.
  if (selectedCategoryIndex == 0) {
    return const AllProductScreen();
  } else if (selectedCategoryIndex == 1) {
    return const CricketScreen();
  } else if (selectedCategoryIndex == 2) {
    return const FootBallScreen();
  } else if (selectedCategoryIndex == 3) {
    return const HockeyScreen();
  } else {
    // Handle other indices or default to AllProductScreen.
    return const AllProductScreen();
  }
}
