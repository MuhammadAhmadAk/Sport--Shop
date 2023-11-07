import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shop_app/core/views/product_detailview.dart';

import '../../bloc/Products/product_cubit.dart';
import '../../bloc/Products/product_state.dart';

class HockeyScreen extends StatefulWidget {
  const HockeyScreen({super.key});

  @override
  State<HockeyScreen> createState() => _HockeyScreenState();
}

class _HockeyScreenState extends State<HockeyScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ProductCubit>().fetchProductsByCategory("Hockey");
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductCubit, ProductState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          body: Column(
            children: [
              SizedBox(
                height: 20.h,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 20.w,
                  ),
                  Text(
                    "Hockey Products",
                    style:
                        GoogleFonts.kanit(fontSize: 15.sp, color: Colors.black),
                  ),
                ],
              ),
              SizedBox(
                height: 20.h,
              ),
              (state is ProductLoadedState)
                  ? Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15.w),
                        child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2, // Number of columns
                            mainAxisSpacing:
                                26.0, // Vertical spacing between items
                            crossAxisSpacing:
                                16.0, // Horizontal spacing between items
                            childAspectRatio: 0.6, // Aspe
                          ),
                          itemCount: state.products.length,
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => DetailScreen(
                                      id: state.products[index].id,
                                      url: state.products[index].imageUrl
                                          .toString(),
                                      name: state.products[index].name,
                                      desp: state.products[index].description,
                                      price: state.products[index].price,
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10.0),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.2),
                                      spreadRadius: 2,
                                      blurRadius: 5,
                                      offset: const Offset(0, 3),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  children: [
                                    Container(
                                      height: 140.h,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10.r),
                                          image: DecorationImage(
                                              fit: BoxFit.fill,
                                              image: NetworkImage(
                                                  '${state.products[index].imageUrl}'))),
                                    ),
                                    SizedBox(
                                      height: 3.h,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 12.0.w),
                                      child: Text(
                                        state.products[index].name.toString(),
                                        style: GoogleFonts.kanit(
                                            fontSize: 11.sp,
                                            color: Colors.black),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 12.0.w),
                                      child: Row(
                                        children: [
                                          Text(
                                            "Rs : ${state.products[index].price}",
                                            style: GoogleFonts.kanit(
                                                fontSize: 15.sp,
                                                color: Colors.black),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 12.0.w),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            state.products[index].category
                                                .toString(),
                                            style: GoogleFonts.kanit(
                                                fontSize: 10.sp,
                                                color: Colors.black),
                                          ),
                                          RatingBar.builder(
                                            itemSize: 15.w,
                                            initialRating: 3,
                                            minRating: 1,
                                            direction: Axis.horizontal,
                                            allowHalfRating: false,
                                            itemCount: 5,
                                            itemBuilder: (context, _) =>
                                                const Icon(
                                              Icons.star,
                                              color: Colors.amber,
                                            ),
                                            onRatingUpdate: (rating) {
                                              print(rating);
                                            },
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    )
                  : Center(
                      child: CircularProgressIndicator(),
                    )
            ],
          ),
        );
      },
    );
  }
}
