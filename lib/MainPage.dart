import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:login_system/admin/Login.dart';
import 'package:login_system/configurations/AppColors.dart';
import 'package:login_system/configurations/BigText.dart';
import 'package:login_system/configurations/SmallText.dart';
import 'package:login_system/models/Authentication.dart';
import 'package:login_system/models/Items.dart';
import 'package:login_system/models/UserClass.dart';
import 'package:login_system/pages/ItemsPage.dart';
import 'package:login_system/pages/MyAccountPage.dart';
import 'package:login_system/pages/UsersPage.dart';
import 'package:login_system/widgets/PlaneTextField.dart';
import 'package:login_system/widgets/PrimayButton.dart';

class MainPage extends StatefulWidget {
  int pageIndex;
  MainPage({
    Key? key,
    this.pageIndex = 0,
  }) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  bool isAdding = false;
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: widget.pageIndex == 0
            ? FloatingActionButton(
                onPressed: () {
                  showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) => Container(
                            // width: ,

                            padding: EdgeInsets.all(20),
                            //  alignment: Alignment.centerLeft,

                            color: Colors.white,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    BigText(
                                      text: "Add New Item",
                                      isCentre: false,
                                    ),
                                    IconButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        icon: Icon(Icons.cancel))
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                PlaneTextField(
                                    isEnabled: isAdding == true ? false : true,
                                    placeholder: "Enter item title",
                                    controller: titleController,
                                    icon: Icons.title,
                                    onChange: () {}),
                                PlaneTextField(
                                    isEnabled: isAdding == true ? false : true,
                                    minLines: 2,
                                    maxLines: 3,
                                    placeholder: "Enter item description",
                                    controller: descController,
                                    icon: Icons.title,
                                    onChange: () {}),
                                PrimaryButton(
                                    TapAction: () async {
                                      if (descController.text == "" ||
                                          titleController.text == "") {
                                        Fluttertoast.showToast(
                                            msg: "Some of Fields are empty");
                                      } else {
                                        setState(() {
                                          isAdding = true;
                                        });

                                        await AddNewItem(titleController.text,
                                            descController.text);

                                        setState(() {
                                          isAdding = false;
                                          titleController.text = "";
                                          descController.text = "";
                                        });

                                        Navigator.pop(context);

                                        Fluttertoast.showToast(
                                            msg: "New Item Added successfully");
                                      }
                                    },
                                    text: "Add Item",
                                    color: AppColors.PrimaryColor,
                                    icon: Icons.add)
                              ],
                            ),
                          ));
                  // showDialog(
                  //     context: context,
                  //     builder: (BuildContext context) => Container(
                  //           // width: 100,
                  //           height: 200,
                  //           color: Colors.white,
                  //           child: Center(child: BigText(text: "This is Text")),
                  //         ));
                },
                backgroundColor: AppColors.PrimaryColor,
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              )
            : SizedBox(),
        bottomNavigationBar: BottomNavigationBar(
            selectedItemColor: AppColors.PrimaryColor,
            onTap: (value) {
              setState(() {
                widget.pageIndex = value;
              });
            },
            currentIndex: widget.pageIndex,
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.list,
                  ),
                  label: "Items"),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.account_tree,
                  ),
                  label: "Users"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.account_circle), label: "Account")
            ]),
        appBar: AppBar(
          backgroundColor: AppColors.PrimaryColor,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SmallText(
                text: widget.pageIndex == 0
                    ? "List of Items"
                    : widget.pageIndex == 1
                        ? "All Users"
                        : "My Account",
                color: Colors.white,
              ),
              IconButton(
                  onPressed: () async {
                    await logOut();
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: ((context) => Login())));
                  },
                  icon: Icon(Icons.logout))
            ],
          ),
        ),
        body: widget.pageIndex == 0
            ? ItemsPage()
            : widget.pageIndex == 2
                ? MyAccountPage()
                : UsersPage());
  }
}
