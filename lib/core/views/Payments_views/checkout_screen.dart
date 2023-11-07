// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shop_app/core/Utils/Widgets/address_textfiled.dart';
import 'package:shop_app/core/Utils/Widgets/custom_appbar.dart';
import 'package:shop_app/core/Utils/Widgets/custom_textfiled.dart';
import 'package:shop_app/core/views/Payments_views/payment_method_screen.dart';

import '../../Utils/Widgets/custom_button.dart';
import '../../models/cart_model.dart';

class CheckoutScreen extends StatefulWidget {
  // You can pass the cart items as a parameter to the checkout screen.
  final List<CartModel> cartItems;

  const CheckoutScreen({super.key, required this.cartItems});

  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(children: [
          ListView(
            children: <Widget>[
              SizedBox(
                height: 20.h,
              ),
              CustomAppBar(title: "CheckOut", applyleading: true),

              SizedBox(height: 10.0.h),
              // List of cart items
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: widget.cartItems.length,
                  itemBuilder: (context, index) {
                    final item = widget.cartItems[index];
                    return CartCardWidget(item: item);
                  },
                ),
              ),

              // Order summary
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Order Summary',
                      style: GoogleFonts.montserrat(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.black.withOpacity(0.7),
                      ),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Text(
                      'Total Items: ${widget.cartItems.length}',
                      style: GoogleFonts.montserrat(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.black.withOpacity(0.7),
                      ),
                    ),
                    SizedBox(
                      height: 3.h,
                    ),
                    Text(
                      'Total Price: Rs : ${calculateTotalPrice()}',
                      style: GoogleFonts.montserrat(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.black.withOpacity(0.7),
                      ),
                    ),
                  ],
                ),
              ),

              // Shipping and payment details input
              // You can include form fields for shipping address, payment details, etc.
              // Here, I'm just using text fields as placeholders.
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Shipping Address',
                      style: GoogleFonts.montserrat(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.black.withOpacity(0.7),
                      ),
                    ),
                    SizedBox(height: 10.0.h),
                    CustomTextField(label: "City"),
                    AddressTextField(label: "Full Address"),

                    // Add more form fields for shipping details here.
                    const SizedBox(height: 16.0),
                    Container(
                      height: 70.h,
                      width: double.infinity,
                      color: Colors.white,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5.0.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustombuttonWidget(
                                text: "Place Order",
                                buttonHeight: 35.h,
                                buttonBackgroundColor: Colors.deepPurpleAccent,
                                buttonWidth: 110.w,
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w400,
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            PaymentMethodScreen(
                                          price: "${calculateTotalPrice()}",
                                        ),
                                      ));
                                }),
                            Text("Total : Rs : ${calculateTotalPrice()}",
                                style: GoogleFonts.montserrat(
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black54,
                                )),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ]),
      ),
    );
  }

  // Helper function to calculate the total price of items in the cart.
  double calculateTotalPrice() {
    double totalPrice = 0.0;
    for (final item in widget.cartItems) {
      double price = double.tryParse(item.price ?? '0') ?? 0;
      int quantity = item.quantity ?? 0;
      totalPrice += price * quantity;
    }
    return totalPrice;
  }
}

class CartCardWidget extends StatefulWidget {
  final CartModel item;

  const CartCardWidget({super.key, required this.item});

  @override
  State<CartCardWidget> createState() => _CartCardWidgetState();
}

class _CartCardWidgetState extends State<CartCardWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shadowColor: Colors.deepPurpleAccent
          .withOpacity(0.3), // Set the card's elevation (shadow)
      margin: EdgeInsets.symmetric(
          horizontal: 16.w, vertical: 5.h), // Add margin around the card
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        // Round the card's corners
      ),
      child: Column(
        children: [
          SizedBox(
            height: 10.h,
          ),
          ListTile(
            title: Row(
              children: [
                Container(
                  height: 50.h,
                  width: 60.w,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.w),
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image:
                              NetworkImage(widget.item.imageUrl.toString()))),
                ),
                SizedBox(
                  width: 10.w,
                ),
                Expanded(
                  child: Text(
                    widget.item.productName!,
                    style: GoogleFonts.montserrat(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
            subtitle: Column(
              children: [
                SizedBox(
                  height: 10.h,
                ),
                Row(
                  children: [
                    Text(
                      'Rs: ${widget.item.price}',
                      style: GoogleFonts.montserrat(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      width: 60.w,
                    ),
                    Text(
                      'Quantity: ${widget.item.quantity}',
                      style: GoogleFonts.montserrat(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
        ],
      ),
    );
  }
}
