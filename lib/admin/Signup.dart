// ignore_for_file: avoid_print, file_names, prefer_final_fields

import 'dart:io';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:login_system/admin/LocationFunctions.dart';
import 'package:login_system/admin/Login.dart';
import 'package:login_system/configurations/AppColors.dart';
import 'package:login_system/configurations/BigText.dart';
import 'package:login_system/configurations/Dimensions.dart';
import 'package:login_system/configurations/SmallText.dart';
import 'package:login_system/models/Authentication.dart';
import 'package:login_system/models/UserClass.dart';
import 'package:login_system/widgets/Loading.dart';
import 'package:login_system/widgets/PlaneTextField.dart';
import 'package:login_system/widgets/PrimayButton.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

class Signup extends StatefulWidget {
  bool isLoading = false;
  Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

String _CurrentAddress = "N/A";

class _SignupState extends State<Signup> {
  String imageaddress = "";
  String imagetoUpload = "";

  TextEditingController _nameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _addressController = TextEditingController();

  String thisiserror = "";
  String LoadingMessage = "Registring User";

  bool _nameEmpty = false;
  bool _emailEmpty = false;
  bool _phoneEmpty = false;
  bool _passwordEmpty = false;
  bool _addressEmpty = false;

  @override
  initState() {
    print(_CurrentAddress);
  }

  @override
  Widget build(BuildContext context) {
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
                  alignment: Alignment.center,
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      BigText(
                        text: "Sign up",
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
                      GestureDetector(
                        onTap: () async {
                          final result = await FilePicker.platform.pickFiles(
                            allowMultiple: false,
                            type: FileType.custom,
                            allowedExtensions: ['png', 'jpg'],
                          );

                          print(result!.files.single.path);
                          if (result == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Error Uploading')));
                          } else {
                            final fileName = result.files.single.name;
                            final filePath = result.files.single.path!;
                            setState(() {
                              imagetoUpload = filePath;
                            });

                            // String ImageURL =
                            //     await uploadAccountImage(fileName, filePath);

                            setState(() {
                              imageaddress = result.files.single.path!;
                            });
                          }
                        },
                        child: Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(60),
                              image: imageaddress != ""
                                  ? DecorationImage(
                                      image: FileImage(
                                        File(imageaddress),
                                      ),
                                      fit: BoxFit.cover)
                                  : DecorationImage(
                                      image: NetworkImage("widget.image"),
                                      fit: BoxFit.cover),
                              color: const Color.fromARGB(255, 231, 231, 231)),
                          child: Center(
                              child: imageaddress == ""
                                  ? const Icon(
                                      Icons.add_a_photo,
                                    )
                                  : const SizedBox()),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      PlaneTextField(
                        isEmpty: _nameEmpty == false ? false : true,
                        onChange: (value) => {
                          setState(() {
                            _nameEmpty = false;
                          })
                        },
                        icon: Icons.account_box,
                        placeholder: 'Name',
                        controller: _nameController,
                      ),
                      _nameEmpty != false
                          ? Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SmallText(
                                    text: " Name field is required",
                                    color: Colors.red,
                                  ),
                                ],
                              ),
                            )
                          : SizedBox(),
                      SizedBox(
                        height: 5,
                      ),
                      PlaneTextField(
                        isEmpty: _emailEmpty == false ? false : true,
                        onChange: (value) => {
                          setState(() {
                            _emailEmpty = false;
                            thisiserror = "";
                          })
                        },
                        icon: Icons.email,
                        placeholder: 'Email',
                        controller: _emailController,
                      ),
                      _emailEmpty != false
                          ? Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SmallText(
                                    text: " Email field is required",
                                    color: Colors.red,
                                  ),
                                ],
                              ),
                            )
                          : SizedBox(),
                      SizedBox(
                        height: 5,
                      ),
                      PlaneTextField(
                        isEmpty: _phoneEmpty == false ? false : true,
                        onChange: (value) => {
                          setState(() {
                            thisiserror = "";
                            _phoneEmpty = false;
                          })
                        },
                        icon: Icons.phone,
                        placeholder: 'Phone',
                        controller: _phoneController,
                      ),
                      _phoneEmpty != false
                          ? Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SmallText(
                                    text: " Phone field is required",
                                    color: Colors.red,
                                  ),
                                ],
                              ),
                            )
                          : SizedBox(),
                      SizedBox(
                        height: 5,
                      ),
                      PlaneTextField(
                        isEmpty: _passwordEmpty == false ? false : true,
                        isPassword: true,
                        onChange: (value) => {
                          setState(() {
                            _passwordEmpty = false;
                            thisiserror = "";
                          })
                        },
                        icon: Icons.lock,
                        placeholder: 'Password',
                        controller: _passwordController,
                      ),
                      _passwordEmpty != false
                          ? Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SmallText(
                                    text: " Password field is required",
                                    color: Colors.red,
                                  ),
                                ],
                              ),
                            )
                          : SizedBox(),
                      PlaneTextField(
                        isEmpty: _addressEmpty == false ? false : true,
                        onChange: (value) => {
                          setState(() {
                            thisiserror = "";
                            _addressEmpty = false;
                          })
                        },
                        icon: Icons.pin_drop,
                        placeholder: 'Address',
                        controller: _addressController,
                      ),
                      _addressEmpty != false
                          ? Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SmallText(
                                    text: " Address field is required",
                                    color: Colors.red,
                                  ),
                                ],
                              ),
                            )
                          : SizedBox(),
                      InkWell(
                        onTap: () async {
                          setState(() {
                            widget.isLoading = true;
                            LoadingMessage = "Fetching your current Location";
                          });

                          await FetchCurrentLocation().then((value) {
                            setState(() {
                              _CurrentAddress = value;
                              print(_CurrentAddress);
                            });
                            //  print(_CurrentAddress);
                            _addressController.text = _CurrentAddress;
                            // _CurrentAddress = value;
                          });

                          setState(() {
                            widget.isLoading = false;
                          });

                          print("Current Location");
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            children: [
                              Icon(
                                Icons.location_searching,
                                color: AppColors.PrimaryColor,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              SmallText(
                                text: "Fetch Current Location",
                                color: AppColors.PrimaryColor,
                              )
                            ],
                          ),
                        ),
                      ),
                      PrimaryButton(
                          icon: Icons.account_circle,
                          TapAction: () async {
                            setState(() {
                              widget.isLoading = true;
                            });
                            if (_nameController.text == "" ||
                                _phoneController.text == "" ||
                                _passwordController.text == "" ||
                                _emailController.text == "" ||
                                _addressController.text == "") {
                              if (_nameController.text == "") {
                                setState(() {
                                  widget.isLoading = false;
                                  _nameEmpty = true;
                                });
                              }
                              if (_emailController.text == "") {
                                setState(() {
                                  widget.isLoading = false;
                                  _emailEmpty = true;
                                });
                              }
                              if (_passwordController.text == "") {
                                setState(() {
                                  widget.isLoading = false;
                                  _passwordEmpty = true;
                                });
                              }
                              if (_addressController.text == "") {
                                setState(() {
                                  widget.isLoading = false;
                                  _addressEmpty = true;
                                });
                              }

                              if (_phoneController.text == "") {
                                setState(() {
                                  widget.isLoading = false;
                                  _phoneEmpty = true;
                                });
                              }

                              // setState(() {
                              //   widget.isLoading = false;
                              //   thisiserror = "One or more fields are empty";
                              // });
                            } else {
                              String imageUploaded = "";
                              if (imagetoUpload == "") {
                                setState(() {
                                  imageUploaded =
                                      "https://firebasestorage.googleapis.com/v0/b/loginsystem-a2798.appspot.com/o/user.png?alt=media&token=d4309a8a-3823-41b9-9d15-2d08a2bcc845";
                                });
                              } else {
                                setState(() {
                                  LoadingMessage =
                                      "Uploading your profile image";
                                });

                                String imageUploaded = "";
                                await uploadProfilePicture(
                                        _emailController.text,
                                        _emailController.text,
                                        imagetoUpload)
                                    .then((value) => imageUploaded = value);
                              }

                              setState(() {
                                LoadingMessage =
                                    "Creating your account on firebase";
                              });

                              bool shouldNavigate = await register(
                                  _emailController.text,
                                  _passwordController.text);

                              if (shouldNavigate) {
                                setState(() {
                                  LoadingMessage = "Saving all Details";
                                });
                                await RegisterNewUser(
                                    imageUploaded,
                                    _nameController.text,
                                    _phoneController.text,
                                    _emailController.text,
                                    _addressController.text);

                                setState(() {
                                  LoadingMessage = "Registed Successfully";
                                });

                                print(
                                    "${_emailController.text} Registered Successfully");

                                setState(() {
                                  widget.isLoading = false;
                                });

                                // ignore: use_build_context_synchronously
                                QuickAlert.show(
                                    context: context,
                                    type: QuickAlertType.success,
                                    text: 'Account Registered Successfully!',
                                    confirmBtnText: "Login",
                                    confirmBtnColor: AppColors.PrimaryColor,
                                    onConfirmBtnTap: () {
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: ((context) => Login())));
                                    },
                                    backgroundColor: Colors.white);
                              } else {
                                setState(() {
                                  widget.isLoading = false;
                                });

                                print("this is first > " + thisiserror);
                                thisiserror = message.toString().replaceRange(
                                    message.toString().indexOf("["),
                                    message.toString().indexOf("]") + 2,
                                    "");
                                print("this is after > " + thisiserror);
                              }
                            }
                          },
                          text: 'Register',
                          color: AppColors.PrimaryColor),
                      SizedBox(
                        height: Dimensions.height15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SmallText(text: "Already have an account ? "),
                          InkWell(
                              onTap: () {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Login()));
                              },
                              child: SmallText(
                                text: "Login",
                                color: Colors.black,
                              ))
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
