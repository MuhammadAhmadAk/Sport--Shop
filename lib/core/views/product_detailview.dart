import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shop_app/bloc/Products/product_cubit.dart';
import 'package:shop_app/bloc/Products/product_state.dart';
import 'package:shop_app/bloc/cart/cart_cubit.dart';
import 'package:shop_app/core/Utils/Widgets/custom_button.dart';
import 'package:shop_app/core/models/cart_model.dart';
import 'package:shop_app/core/views/Payments_views/payment_method_screen.dart';

class DetailScreen extends StatefulWidget {
  final String? url;
  final String? name;
  final String? id;
  final String? desp;
  final double? price;
  const DetailScreen(
      {super.key,
      required this.url,
      required this.name,
      required this.desp,
      this.price,
      this.id});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  int quantity = 0;
  void incrementQuantity() {
    setState(() {
      quantity++;
    });
  }

  void decrementQuantity() {
    if (quantity > 0) {
      setState(() {
        quantity--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  height: 300.h,
                  decoration: BoxDecoration(
                      color: Colors.cyan,
                      image: DecorationImage(
                          fit: BoxFit.fill,
                          image: NetworkImage(widget.url.toString()))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(16.0.w),
                        child: IconButton(
                            onPressed: () {
                              context.read<CartCubit>().getAllCartItems();
                              Navigator.pop(context);
                            },
                            icon: Icon(
                              Icons.arrow_back_ios,
                              size: 30.w,
                              color: Colors.white,
                            )),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(16.w),
                  child: Padding(
                    padding: EdgeInsets.all(16.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.name.toString(),
                          style: GoogleFonts.montserrat(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 16.h),
                        Row(
                          children: [
                            Text(
                              "Rs : ",
                              style: GoogleFonts.montserrat(
                                fontSize: 24.sp,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              widget.price.toString(),
                              style: GoogleFonts.montserrat(
                                fontSize: 24.sp,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(
                              width: 50.w,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Container(
                                  height: 32.h,
                                  width: 32.w,
                                  decoration: BoxDecoration(
                                    color: Colors.black,
                                  ),
                                  child: Center(
                                    child: IconButton(
                                      icon: const Icon(
                                        Icons.remove,
                                        color: Colors.white,
                                      ),
                                      onPressed: decrementQuantity,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 10.w,
                                ),
                                Text(
                                  '$quantity',
                                  style: GoogleFonts.montserrat(
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black,
                                  ),
                                ),
                                SizedBox(
                                  width: 10.w,
                                ),
                                Container(
                                  height: 32.h,
                                  width: 32.w,
                                  decoration: BoxDecoration(
                                    color: Colors.black,
                                  ),
                                  child: Center(
                                    child: IconButton(
                                      icon: const Center(
                                        child: Icon(
                                          Icons.add,
                                          color: Colors.white,
                                        ),
                                      ),
                                      onPressed: incrementQuantity,
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                        SizedBox(height: 16.h),
                        const Divider(),
                        Text(
                          "Product Description",
                          style: GoogleFonts.montserrat(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          widget.desp.toString(),
                          style: GoogleFonts.montserrat(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.normal,
                            color: Colors.black.withOpacity(0.7),
                          ),
                        ),
                        SizedBox(height: 16.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Product Reveiws",
                              style: GoogleFonts.montserrat(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                            ),
                            RatingBar.builder(
                              itemSize: 15.w,
                              initialRating: 3,
                              minRating: 1,
                              direction: Axis.horizontal,
                              allowHalfRating: false,
                              itemCount: 5,
                              itemBuilder: (context, _) => const Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              onRatingUpdate: (rating) {
                                print(rating);
                              },
                            )
                          ],
                        ),
                        SizedBox(height: 8.h),
                        Column(
                          children: [
                            Text(
                              "1 .felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat",
                              style: GoogleFonts.montserrat(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.normal,
                                color: Colors.black.withOpacity(0.7),
                              ),
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Image.network(
                                  "https://images.unsplash.com/photo-1651421977986-10a615d218a7?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1471&q=80",
                                  height: 50.h,
                                ),
                                Image.network(
                                  "https://images.unsplash.com/photo-1651421977986-10a615d218a7?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1471&q=80",
                                  height: 50.h,
                                ),
                                Image.network(
                                  "https://images.unsplash.com/photo-1651421977986-10a615d218a7?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1471&q=80",
                                  height: 50.h,
                                )
                              ],
                            )
                          ],
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Column(
                          children: [
                            Text(
                              "2 .felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat",
                              style: GoogleFonts.montserrat(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.normal,
                                color: Colors.black.withOpacity(0.7),
                              ),
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Image.network(
                                  "https://images.unsplash.com/photo-1651421977986-10a615d218a7?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1471&q=80",
                                  height: 50.h,
                                ),
                                Image.network(
                                  "https://images.unsplash.com/photo-1651421977986-10a615d218a7?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1471&q=80",
                                  height: 50.h,
                                ),
                                Image.network(
                                  "https://images.unsplash.com/photo-1651421977986-10a615d218a7?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1471&q=80",
                                  height: 50.h,
                                )
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  height: 100.h,
                )
              ],
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              height: 75.h,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5), // Shadow color
                    spreadRadius: 0.w, // Spread radius
                    blurRadius: 2, // Blur radius
                    offset: Offset.zero, // Offset
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "RS : ${widget.price.toString()}",
                    style: GoogleFonts.montserrat(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.black.withOpacity(0.7),
                    ),
                  ),
                  CustombuttonWidget(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PaymentMethodScreen(
                              price: widget.price.toString(),
                            ),
                          ));
                    },
                    text: "Buy",
                    buttonBackgroundColor: Colors.deepPurpleAccent,
                    buttonHeight: 35.h,
                    buttonWidth: 90.w,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w400,
                  ),
                  BlocConsumer<ProductCubit, ProductState>(
                    listener: (context, state) {
                      if (state is AddtoCartState) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Item added to cart!"),
                            backgroundColor: Colors.green,
                          ),
                        );
                      }
                    },
                    builder: (context, state) {
                      final cartItem = CartModel(
                          productId: widget.id.toString(),
                          productName: widget.name.toString(),
                          price: widget.price.toString(),
                          quantity: quantity,
                          imageUrl: widget.url.toString());
                      return (state is ProductLoadingState)
                          ? Center(
                              child: CircularProgressIndicator(),
                            )
                          : CustombuttonWidget(
                              onPressed: () {
                                context
                                    .read<ProductCubit>()
                                    .addToCart(cartItem);
                              },
                              text: "Add to Cart",
                              buttonHeight: 35.h,
                              buttonBackgroundColor: Colors.deepPurpleAccent,
                              buttonWidth: 110.w,
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w400,
                            );
                    },
                  )
                ],
              ),
            ),
          ),
        ],
      )),
    );
  }
}
