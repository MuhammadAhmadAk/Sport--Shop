import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shop_app/bloc/cart/cart_cubit.dart';
import 'package:shop_app/bloc/cart/cart_state.dart';
import 'package:shop_app/core/Utils/Widgets/custom_button.dart';
import 'package:shop_app/core/models/cart_model.dart';
import 'package:shop_app/core/views/Payments_views/checkout_screen.dart';

import '../Utils/Widgets/custom_appbar.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  void removeSelectedItemsFromCart(List<CartModel> selectedItems) {
    final itemsToRemove =
        selectedItems.where((item) => item.isSelected).toList();
    if (itemsToRemove.isNotEmpty) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Confirm Delete'),
            content: Text(
              'Are you sure you want to delete these items from the cart?',
              style: TextStyle(fontSize: 16),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
                child: Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  // Remove selected items from the cart
                  itemsToRemove.forEach((item) {
                    context.read<CartCubit>().removeItemCart(item);
                  });
                  Navigator.of(context).pop(); // Close the dialog
                },
                child: Text('Delete'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CartCubit, CartState>(
      listener: (context, state) {
        // Handle any state changes if needed
      },
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
            child: (state is CartItemLoadedState)
                ? Column(
                    children: [
                      SizedBox(
                        height: 20.h,
                      ),
                      CustomAppBar(title: "Cart", applyleading: true),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: () {
                                removeSelectedItemsFromCart(
                                    state.cartItems as List<CartModel>);
                              },
                              child: Text(
                                "Delete Selected",
                                style: GoogleFonts.montserrat(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w500,
                                  color:
                                      Colors.deepPurpleAccent.withOpacity(0.7),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: state.cartItems!.length,
                          itemBuilder: (BuildContext context, int index) {
                            final item = state.cartItems![index];
                            return CartCardWidget(item: item);
                          },
                        ),
                      ),
                      Container(
                        height: 70.h,
                        width: double.infinity,
                        color: Colors.white10,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustombuttonWidget(
                                  text: "Processed",
                                  buttonHeight: 35.h,
                                  buttonBackgroundColor:
                                      Colors.deepPurpleAccent,
                                  buttonWidth: 110.w,
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w400,
                                  onPressed: () {
                                    final selectedItems =
                                        (state.cartItems as List<CartModel>)
                                            .where((item) => item.isSelected)
                                            .toList();
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => CheckoutScreen(
                                              cartItems: selectedItems),
                                        ));
                                  }),
                              Text(
                                  "Total: Rs : ${calculateTotal(state.cartItems as List<CartModel>)}",
                                  style: GoogleFonts.montserrat(
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black54,
                                  )),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                : Center(
                    child: CircularProgressIndicator(),
                  ),
          ),
        );
      },
    );
  }

  double calculateTotal(List<CartModel> cartItems) {
    double total = 0;
    for (var item in cartItems) {
      if (item.isSelected) {
        total += double.parse(item.price!) * item.quantity!;
      }
    }
    return total;
  }
}

class CartCardWidget extends StatefulWidget {
  final CartModel item;

  const CartCardWidget({super.key, required this.item});

  @override
  State<CartCardWidget> createState() => _CartCardWidgetState();
}

class _CartCardWidgetState extends State<CartCardWidget> {
  int quantity = 0;
  @override
  void initState() {
    super.initState();
    quantity = widget.item.quantity!;
  }

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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () => decrementQuantity(),
                          child: Container(
                            height: 20.h,
                            width: 20.w,
                            decoration: BoxDecoration(
                                color: Colors.deepPurpleAccent,
                                borderRadius: BorderRadius.circular(10.r)),
                            child: Center(
                              child: Icon(
                                Icons.remove,
                                color: Colors.white,
                                size: 17.w,
                              ),
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
                        GestureDetector(
                          onTap: () => incrementQuantity(),
                          child: Container(
                            height: 20.h,
                            width: 20.w,
                            decoration: BoxDecoration(
                                color: Colors.deepPurpleAccent,
                                borderRadius: BorderRadius.circular(10.r)),
                            child: Center(
                              child: Icon(
                                Icons.add,
                                color: Colors.white,
                                size: 17.w,
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),
            trailing: Checkbox(
              activeColor: Colors.deepPurpleAccent,
              autofocus: true,
              value: widget.item.isSelected,
              onChanged: (bool? value) {
                context.read<CartCubit>().toggleItemSelection(widget.item);
              },
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
