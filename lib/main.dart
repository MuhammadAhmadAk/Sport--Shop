import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_app/bloc/Auth/auth_cubit.dart';
import 'package:shop_app/bloc/Products/product_cubit.dart';
import 'package:shop_app/bloc/cart/cart_cubit.dart';
import 'package:shop_app/core/views/splash_screen.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AuthCubit(),
          ),
          BlocProvider(
            create: (context) => ProductCubit(),
          ),
          BlocProvider(
            create: (context) => CartCubit(),
          )
        ],
        child: const ScreenUtilInit(
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Sport Shop',
            home: SplashScreen(),
          ),
        ));
  }
}
