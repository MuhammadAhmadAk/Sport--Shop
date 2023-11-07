import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shop_app/core/Utils/Widgets/custom_appbar.dart';
import 'package:shop_app/core/Utils/Widgets/custom_button.dart';
import 'package:shop_app/core/views/Payments_views/credit_card_form.dart';

class PaymentMethodScreen extends StatefulWidget {
  final String price;

  const PaymentMethodScreen({
    super.key,
    required this.price,
  });

  @override
  State<PaymentMethodScreen> createState() => _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends State<PaymentMethodScreen> {
  String selectedPaymentMethod = ''; // To store the selected payment method

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.all(16.0),
          children: [
            SizedBox(
              height: 20.h,
            ),
            const CustomAppBar(title: "Payment Methods", applyleading: true),
            SizedBox(
              height: 20.h,
            ),
            Card(
              elevation: 1.5,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 8.h),
                height: 60.h,
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.black12)),
                child: ListTile(
                  title: Row(
                    children: [
                      Image.asset(
                        'assets/images/ep.png',
                        height: 30.h,
                      ),
                      SizedBox(
                        width: 30.w,
                      ),
                      Text(
                        'EasyPaisa',
                        style: GoogleFonts.montserrat(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.black.withOpacity(0.7),
                        ),
                      ),
                    ],
                  ),
                  leading: Radio<String>(
                    activeColor: Colors.deepPurpleAccent,
                    value: 'EasyPaisa',
                    groupValue: selectedPaymentMethod,
                    onChanged: (value) {
                      setState(() {
                        selectedPaymentMethod = value!;
                      });
                    },
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Card(
              elevation: 1.5,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 8.h),
                height: 60.h,
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.black12)),
                child: ListTile(
                  title: Row(
                    children: [
                      Image.asset(
                        'assets/images/Jc.png',
                        height: 30.h,
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      Text(
                        'JazzCash',
                        style: GoogleFonts.montserrat(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.black.withOpacity(0.7),
                        ),
                      ),
                    ],
                  ),
                  leading: Radio<String>(
                    activeColor: Colors.deepPurpleAccent,
                    value: 'JazzCash',
                    groupValue: selectedPaymentMethod,
                    onChanged: (value) {
                      setState(() {
                        selectedPaymentMethod = value!;
                      });
                    },
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Card(
              elevation: 1.5,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 8.h),
                height: 60.h,
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.black12)),
                child: ListTile(
                  title: Row(
                    children: [
                      Image.asset(
                        'assets/images/cc.png',
                        height: 30.h,
                      ),
                      SizedBox(
                        width: 20.w,
                      ),
                      Text(
                        'Credit Card',
                        style: GoogleFonts.montserrat(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.black.withOpacity(0.7),
                        ),
                      ),
                    ],
                  ),
                  leading: Radio<String>(
                    activeColor: Colors.deepPurpleAccent,
                    value: 'CreditCard',
                    groupValue: selectedPaymentMethod,
                    onChanged: (value) {
                      setState(() {
                        selectedPaymentMethod = value!;
                      });
                    },
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 300.h,
            ),
            CustombuttonWidget(
                text: "Processed to the payments",
                buttonWidth: 330.w,
                buttonHeight: 50.h,
                fontWeight: FontWeight.w500,
                buttonBackgroundColor: Colors.deepPurpleAccent,
                onPressed: () {
                  // Process the selected payment method
                  if (selectedPaymentMethod.isNotEmpty) {
                    if (selectedPaymentMethod == "CreditCard") {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CreditCardView(
                              price: widget.price.toString(),
                            ),
                          ));
                    }
                  } else {
                    // Show an error message if no payment method is selected
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text(
                            'Error',
                            style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w700,
                              color: Colors.black,
                            ),
                          ),
                          content: Text(
                            'Please select a payment method.',
                            style: GoogleFonts.montserrat(
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text(
                                'OK',
                                style: GoogleFonts.montserrat(
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.deepPurpleAccent,
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  }
                }),
          ],
        ),
      ),
    );
  }
}
