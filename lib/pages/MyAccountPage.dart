import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_system/configurations/AppColors.dart';
import 'package:login_system/configurations/BigText.dart';
import 'package:login_system/configurations/SmallText.dart';
import 'package:login_system/models/UserClass.dart';

class MyAccountPage extends StatefulWidget {
  const MyAccountPage({super.key});

  @override
  State<MyAccountPage> createState() => _MyAccountPageState();
}

class _MyAccountPageState extends State<MyAccountPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 3.0),
      constraints: BoxConstraints(minHeight: 100, maxHeight: 500),
      child: StreamBuilder(
          stream: AllUsers(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data!.docs.isNotEmpty) {
                return ListView(
                    padding: EdgeInsets.zero,
                    scrollDirection: Axis.vertical,
                    children: snapshot.data!.docs.map(
                      (e) {
                        String imageAddress;

                        return GestureDetector(
                          child: Container(
                            padding: EdgeInsets.only(bottom: 5),
                            decoration: const BoxDecoration(
                              border: Border(
                                // top: BorderSide(width: 16.0, color: Colors.lightBlue.shade600),
                                bottom: BorderSide(
                                    width: 2.0,
                                    color: Color.fromARGB(255, 237, 237, 237)),
                              ),
                            ),
                            //  padding: EdgeInsets.all(10),
                            child: Column(
                              children: [
                                e["UserId"] ==
                                        FirebaseAuth.instance.currentUser?.uid
                                    // e["email"] !=
                                    //         FirebaseAuth.instance
                                    //             .currentUser?.email
                                    ? Column(children: [
                                        Stack(
                                          alignment: Alignment.bottomCenter,
                                          children: [
                                            Container(
                                              margin: const EdgeInsets.only(
                                                  bottom: 30),
                                              height: 150,
                                              decoration: const BoxDecoration(
                                                  image: DecorationImage(
                                                      image: NetworkImage(
                                                          "https://images.unsplash.com/photo-1631631480669-535cc43f2327?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=387&q=80"),
                                                      fit: BoxFit.cover)),
                                            ),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                CircleAvatar(
                                                    radius: 40,
                                                    backgroundColor:
                                                        Colors.white,
                                                    foregroundImage:
                                                        NetworkImage(
                                                            e["ProfileImage"])),
                                              ],
                                            )
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        BigText(
                                          text: e["username"],
                                          color: AppColors.PrimaryColor,
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Container(
                                            decoration: const BoxDecoration(
                                                border: Border(
                                                    bottom: BorderSide(
                                                        color: Color.fromARGB(
                                                            255,
                                                            188,
                                                            188,
                                                            188)))),
                                            margin: const EdgeInsets.all(5),
                                            padding: const EdgeInsets.all(5),
                                            child: ListTile(
                                              leading: Icon(
                                                Icons.email,
                                                color: AppColors.PrimaryColor,
                                              ),
                                              title: BigText(text: "Email"),
                                              subtitle:
                                                  SmallText(text: e["email"]),
                                              trailing: const Icon(
                                                  Icons.arrow_forward_ios),
                                            )),
                                        Container(
                                            decoration: const BoxDecoration(
                                                border: Border(
                                                    bottom: BorderSide(
                                                        color: Color.fromARGB(
                                                            255,
                                                            188,
                                                            188,
                                                            188)))),
                                            margin: const EdgeInsets.all(5),
                                            padding: const EdgeInsets.all(5),
                                            child: ListTile(
                                              leading: Icon(
                                                Icons.location_city,
                                                color: AppColors.PrimaryColor,
                                              ),
                                              title: BigText(text: "Address"),
                                              subtitle:
                                                  SmallText(text: e["Address"]),
                                              trailing: const Icon(
                                                  Icons.arrow_forward_ios),
                                            )),
                                        Container(
                                            decoration: const BoxDecoration(
                                                border: Border(
                                                    bottom: BorderSide(
                                                        color: Color.fromARGB(
                                                            255,
                                                            188,
                                                            188,
                                                            188)))),
                                            margin: const EdgeInsets.all(5),
                                            padding: const EdgeInsets.all(5),
                                            child: ListTile(
                                              leading: Icon(
                                                Icons.phone,
                                                color: AppColors.PrimaryColor,
                                              ),
                                              title: BigText(text: "Phone"),
                                              subtitle:
                                                  SmallText(text: e["Phoneno"]),
                                              trailing: const Icon(
                                                  Icons.arrow_forward_ios),
                                            )),
                                      ])
                                    : const SizedBox(),
                              ],
                            ),
                          ),
                        );
                      },
                    ).toList());
              } else {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    BigText(
                      text: "No User Register Yet",
                      isCentre: true,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    SmallText(text: "There is no user exists yet in database")
                  ],
                );
              }
            } else {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  BigText(text: "No User Register Yet"),
                  SizedBox(
                    height: 5,
                  ),
                  SmallText(text: "There is no user exists yet in database")
                ],
              );
            }
          }),
    );
  }
}
