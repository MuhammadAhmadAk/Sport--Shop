import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shop_app/bloc/Auth/auth_cubit.dart';
import 'package:shop_app/bloc/Auth/auth_state.dart';
import 'package:shop_app/core/Utils/Widgets/custom_button.dart';
import 'package:shop_app/core/Utils/Widgets/custom_paswordfield.dart';
import 'package:shop_app/core/Utils/Widgets/custom_textfiled.dart';
import 'package:shop_app/core/views/Auth/registor_screen.dart';
import 'package:shop_app/core/views/home_screen.dart';

import '../../Utils/sharedpref_helper.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  @override
  void dispose() {
    super.dispose();

    emailController.dispose();
    passController.dispose();
  }

  void clearController() {
    emailController.clear();
    passController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthLoggedInState) {
          User? curUser = FirebaseAuth.instance.currentUser;
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => HomeScreen(
                  curUser: curUser!,
                  userModel: state.userModel,
                ),
              ));
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Login successful!"),
              backgroundColor: Colors.green,
            ),
          );
          clearController();
        } else if (state is AuthErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.error.toString()),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
              child: Column(
            children: [
              SizedBox(
                height: 20.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Login",
                    style: GoogleFonts.montserrat(fontSize: 30.sp),
                  ),
                ],
              ),
              CustomTextField(
                label: "Email",
                controller: emailController,
              ),
              SizedBox(
                height: 10.h,
              ),
              PasswordTextfield(
                label: "Password",
                controller: passController,
              ),
              SizedBox(
                height: 10.h,
              ),
              (state is AuthLoadingState)
                  ? Center(
                      child: CircularProgressIndicator(
                          color: Colors.deepPurpleAccent),
                    )
                  : CustombuttonWidget(
                      text: "Login",
                      buttonWidth: 330.w,
                      buttonHeight: 50.h,
                      buttonBackgroundColor: Colors.deepPurpleAccent,
                      onPressed: () async {
                        if (emailController.text != "" &&
                            passController.text != "") {
                          await context.read<AuthCubit>().login(
                              emailController.text.trim(),
                              passController.text.trim());
                          await SharedPreferenceHelper.setLoggedIn(true);
                          await SharedPreferenceHelper.setEmail(
                              emailController.text);
                          await SharedPreferenceHelper.setPassword(
                              passController.text);
                        } else {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text('Error'),
                                content:
                                    Text('Email and password cannot be empty.'),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text('OK'),
                                  ),
                                ],
                              );
                            },
                          );
                        }
                      }),
              SizedBox(
                height: 10.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "don't have a account ?",
                    style: GoogleFonts.montserrat(fontSize: 15.sp),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RegistorScreen(),
                          ));
                    },
                    child: Text(
                      "Registor",
                      style: GoogleFonts.montserrat(
                          fontSize: 15.sp, color: Colors.deepPurpleAccent),
                    ),
                  ),
                ],
              ),
            ],
          )),
        );
      },
    );
  }
}
