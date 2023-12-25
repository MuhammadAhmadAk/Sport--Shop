import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shop_app/bloc/Auth/auth_cubit.dart';
import 'package:shop_app/bloc/Auth/auth_state.dart';
import 'package:shop_app/core/Utils/Widgets/custom_button.dart';
import 'package:shop_app/core/Utils/Widgets/custom_paswordfield.dart';
import 'package:shop_app/core/Utils/Widgets/custom_textfiled.dart';
import 'package:shop_app/core/views/Auth/login_screen.dart';

class RegistorScreen extends StatefulWidget {
  const RegistorScreen({super.key});

  @override
  State<RegistorScreen> createState() => _RegistorScreenState();
}

class _RegistorScreenState extends State<RegistorScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();
  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    emailController.dispose();
    passController.dispose();
    confirmPassController.dispose();
  }

  void clearController() {
    nameController.clear();
    emailController.clear();
    passController.clear();
    confirmPassController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthRegisterSuccessfullState) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Registration successful!"),
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
              child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 20.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Registor",
                      style: GoogleFonts.montserrat(fontSize: 30.sp),
                    ),
                  ],
                ),
                CustomTextField(
                  label: "Name",
                  controller: nameController,
                ),
                SizedBox(
                  height: 10.h,
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
                PasswordTextfield(
                  label: "Confirm Password",
                  controller: confirmPassController,
                ),
                SizedBox(
                  height: 20.h,
                ),
                (state is AuthLoadingState)
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : CustombuttonWidget(
                        text: "Registor",
                        buttonWidth: 330.w,
                        buttonHeight: 50.h,
                        buttonBackgroundColor: Colors.deepPurpleAccent,
                        onPressed: () async {
                          if (passController.text == confirmPassController) {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return PasswordMatchDialog(
                                    passwordMatch: false);
                              },
                            );
                          } else {
                            await context.read<AuthCubit>().registor(
                                nameController.text,
                                emailController.text.trim(),
                                passController.text.trim());
                          }
                        }),
                SizedBox(
                  height: 10.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "already have a account ?",
                      style: GoogleFonts.montserrat(fontSize: 15.sp),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginScreen(),
                            ));
                      },
                      child: Text(
                        "Login",
                        style: GoogleFonts.montserrat(
                            fontSize: 15.sp, color: Colors.deepPurpleAccent),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )),
        );
      },
    );
  }
}

class PasswordMatchDialog extends StatelessWidget {
  final bool passwordMatch;

  const PasswordMatchDialog({super.key, required this.passwordMatch});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Password Confirmation'),
      content: Text(
        passwordMatch
            ? 'Password and Confirm Password match.'
            : 'Password and Confirm Password do not match.',
      ),
      actions: <Widget>[
        TextButton(
          child: Text('OK'),
          onPressed: () {
            Navigator.of(context).pop(); // Close the dialog
          },
        ),
      ],
    );
  }
}
