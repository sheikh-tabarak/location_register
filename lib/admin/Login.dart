import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:login_system/MainPage.dart';
import 'package:login_system/admin/ForgetPassword.dart';
import 'package:login_system/admin/Signup.dart';
import 'package:login_system/configurations/BigText.dart';
import 'package:login_system/models/Authentication.dart';
import 'package:login_system/widgets/Loading.dart';
import 'package:login_system/configurations/AppColors.dart';
import 'package:login_system/models/UserClass.dart';
import 'package:login_system/widgets/PlaneTextField.dart';
import 'package:login_system/widgets/PrimayButton.dart';
import 'package:overlay_loader_with_app_icon/overlay_loader_with_app_icon.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import '../../../configurations/Dimensions.dart';
import '../../../configurations/SmallText.dart';

class Login extends StatefulWidget {
  bool isLoading = false;
  Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  String thisiserror = "";
  String LoadingMessage = "Logging in";

  @override
  initState() {}

  @override
  Widget build(BuildContext context) {
    UserClass Ue;
    return Scaffold(
      backgroundColor: AppColors.darkBackgroundColor,
      body: widget.isLoading == true
          ? Loading(
              message: LoadingMessage,
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
                        text: "Sign in",
                        size: 30,
                        color: AppColors.PrimaryColor,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 12, right: 12),
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
                                color: const Color.fromARGB(255, 255, 255, 255),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
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
                      PlaneTextField(
                        isPassword: true,
                        onChange: (value) => {
                          setState(() {
                            thisiserror = "";
                          })
                        },
                        icon: Icons.lock,
                        placeholder: 'Password',
                        controller: _passwordController,
                      ),
                      PrimaryButton(
                          icon: Icons.login,
                          TapAction: () async {
                            setState(() {
                              widget.isLoading = true;
                            });
                            if (_emailController.text.isEmpty ||
                                _passwordController.text.isEmpty) {
                              setState(() {
                                thisiserror = "One or more fields are empty";
                                widget.isLoading = false;
                              });
                            } else {
                              bool shouldLogin = await signIn(
                                  _emailController.text,
                                  _passwordController.text);

                              if (shouldLogin) {
                                setState(() {
                                  LoadingMessage = "Logged In Successfully";
                                });

                                Fluttertoast.showToast(msg: "Main Page");

                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: ((context) => MainPage())));
                              } else {
                                setState(() {
                                  widget.isLoading = false;
                                  thisiserror = message.toString().replaceRange(
                                      message.toString().indexOf("["),
                                      message.toString().indexOf("]") + 2,
                                      "");

                                  print("this is after > $thisiserror");
                                });
                              }
                            }
                          },
                          text: 'Login',
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
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SmallText(text: "Forget Password ? "),
                          InkWell(
                              onTap: () {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ForgetPassword()));
                              },
                              child: SmallText(
                                text: "Reset now",
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
