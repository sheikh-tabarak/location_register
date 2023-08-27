import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:login_system/admin/Login.dart';
import 'package:login_system/admin/Signup.dart';
import 'package:login_system/configurations/AppColors.dart';
import 'package:login_system/configurations/BigText.dart';
import 'package:login_system/configurations/Dimensions.dart';
import 'package:login_system/configurations/SmallText.dart';
import 'package:login_system/models/Authentication.dart';
import 'package:login_system/widgets/Loading.dart';
import 'package:login_system/widgets/PlaneTextField.dart';
import 'package:login_system/widgets/PrimayButton.dart';

class ForgetPassword extends StatefulWidget {
  ForgetPassword({super.key});
  bool isLoading = false;

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  String thisiserror = "";
  TextEditingController _emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBackgroundColor,
      body: widget.isLoading == true
          ? Loading(
              message: "Sending reset link to your email",
            )
          : Container(
              alignment: Alignment.center,
              child: SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 30,
                      ),
                      BigText(
                        text: "Forget Password",
                        size: 30,
                        color: AppColors.PrimaryColor,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 10, left: 10),
                        child: SmallText(
                            iscentre: true,
                            text:
                                "Don't worry if you forgot your Password, we have a solution for you, Just enter your assosiated email here to get a password reset link"),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      thisiserror != ""
                          ? Container(
                              margin:
                                  const EdgeInsets.only(left: 12, right: 12),
                              padding: const EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                color: thisiserror == ""
                                    ? AppColors.darkBackgroundColor
                                    : Colors.red,
                                borderRadius: BorderRadius.circular(7),
                              ),
                              child: Row(
                                verticalDirection: VerticalDirection.down,
                                textDirection: TextDirection.ltr,
                                children: [
                                  Icon(
                                    Icons.error,
                                    color: thisiserror == ""
                                        ? AppColors.darkBackgroundColor
                                        : Colors.white,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: SmallText(
                                      iscentre: false,
                                      text: thisiserror,
                                      color: const Color.fromARGB(
                                          255, 255, 255, 255),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : const SizedBox(
                              height: 15,
                            ),
                      PlaneTextField(
                        onChange: (value) => {
                          setState(() {
                            thisiserror = "";
                          })
                        },
                        icon: Icons.email,
                        placeholder: 'Email',
                        controller: _emailController,
                      ),
                      PrimaryButton(
                          icon: Icons.login,
                          TapAction: () async {
                            setState(() {
                              widget.isLoading = true;
                            });
                            if (_emailController.text.isEmpty) {
                              setState(() {
                                thisiserror = "Email field is empty";
                                widget.isLoading = false;
                              });
                            } else {
                              bool shouldLogin =
                                  await resetmypassword(_emailController.text);

                              if (shouldLogin == true) {
                                Fluttertoast.showToast(
                                    msg:
                                        "Check your email for Password Reset Link");

                                setState(() {
                                  widget.isLoading = false;

                                  print("this is after > $thisiserror");
                                });

                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: ((context) => Login())));
                              } else {
                                setState(() {
                                  thisiserror = message.toString().replaceRange(
                                      message.toString().indexOf("["),
                                      message.toString().indexOf("]") + 2,
                                      "");
                                  widget.isLoading = false;

                                  print("this is after > $thisiserror");
                                });
                              }
                            }
                          },
                          text: 'Reset Password',
                          color: AppColors.PrimaryColor),
                      SizedBox(
                        height: Dimensions.height15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SmallText(text: "Don't have account ? "),
                          InkWell(
                              onTap: () {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Signup()));
                              },
                              child: SmallText(
                                text: "Sign up",
                                color: Colors.black,
                              ))
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
