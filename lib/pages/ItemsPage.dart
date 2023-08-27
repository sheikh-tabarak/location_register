import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_system/configurations/AppColors.dart';
import 'package:login_system/configurations/BigText.dart';
import 'package:login_system/configurations/SmallText.dart';
import 'package:login_system/models/Items.dart';
import 'package:login_system/widgets/PlaneTextField.dart';

class ItemsPage extends StatefulWidget {
  ItemsPage({super.key});

  @override
  State<ItemsPage> createState() => _ItemsPageState();
}

class _ItemsPageState extends State<ItemsPage> {
  TextEditingController itemSearchController = TextEditingController();

  String searchText = "";

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(children: [
        PlaneTextField(
            placeholder: "Search Items",
            controller: itemSearchController,
            icon: Icons.search,
            onChange: (value) {
              setState(() {
                searchText = value;
              });
            }),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 3.0),
          constraints: BoxConstraints(minHeight: 100, maxHeight: 500),
          child: StreamBuilder(
              stream: ItemsofUser(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data!.docs.isNotEmpty) {
                    return ListView(
                        padding: EdgeInsets.zero,
                        // scrollDirection: Axis.vertical,
                        children: snapshot.data!.docs.map((e) {
                          if (e["title"]
                                  .toString()
                                  .toLowerCase()
                                  .contains(searchText.toLowerCase()) ||
                              e["description"]
                                  .toString()
                                  .toLowerCase()
                                  .contains(searchText.toLowerCase())) {
                            return Container(
                              margin: EdgeInsets.all(10),
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 224, 224, 224),
                                  borderRadius: BorderRadius.circular(5)),
                              child: ListTile(
                                title: BigText(text: e["title"]),
                                subtitle: SmallText(text: e["description"]),
                                trailing: IconButton(
                                    onPressed: () {
                                      showDialog(
                                          context: context,
                                          builder: (context) => AlertDialog(
                                                title: BigText(
                                                    text: "Are you sure ?"),
                                                content: SmallText(
                                                    text:
                                                        "Click Confirm if you want to delete this item"),
                                                actions: [
                                                  TextButton(
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                      child: SmallText(
                                                          text: "Cancel")),
                                                  TextButton(
                                                      onPressed: () async {
                                                        await deleteItem(
                                                            e["Id"]);
                                                        Navigator.pop(context);
                                                      },
                                                      child: SmallText(
                                                        text: "Delete",
                                                        color: Colors.red,
                                                      ))
                                                ],
                                              ));
                                      // showDialog(context: , builder: builder)
                                    },
                                    icon: Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    )),
                              ),
                            );
                          } else {
                            return SizedBox();
                          }
                        }).toList());
                  } else {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        BigText(
                          text: "No Item added yet",
                          isCentre: true,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        SmallText(
                            text: "There is no item for this user in database")
                      ],
                    );
                  }
                } else {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      BigText(text: "No Item added yet"),
                      SizedBox(
                        height: 5,
                      ),
                      SmallText(
                          text: "There is no item for this user in database")
                    ],
                  );
                }
              }),
        )
      ]),
    );
  }
}
