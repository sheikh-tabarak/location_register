import 'dart:io';
import 'package:path/path.dart' as Path;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

final _db = FirebaseFirestore.instance;

class Items {
  final String Id;
  final String title;
  final String description;

  const Items({
    required this.Id,
    required this.description,
    required this.title,
  });

  Map<String, dynamic> toJson() => {
        'Id': Id,
        'description': description,
        'title': title,
      };

  factory Items.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return Items(
      Id: data["Id"],
      description: data["description"],
      title: data["title"],
    );
  }
}

Future AddNewItem(String Itemtitle, String ItemDescription) async {
  //Add Product

  final PostRequest = await FirebaseFirestore.instance
      .collection('user')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection("items")
      .doc();

  // Upload Image
  // String imageUploaded = "";
  // await uploadProductImage(PostRequest.id, ImageFileadress)
  //     .then((value) => imageUploaded = value);

  final NewItem = Items(
    Id: PostRequest.id,
    title: Itemtitle,
    description: ItemDescription,
  );

  final json = NewItem.toJson();
  await PostRequest.set(json);
}

Future deleteItem(String ItemId) async {
  await FirebaseFirestore.instance
      .collection('user')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection("items")
      .doc(ItemId)
      .delete()
      .then((value) {});

  //var fileUrl = Uri.decodeFull(Path.basename(ProductId));
  // final desertRef = firebase_storage.FirebaseStorage.instance
  //     .ref("${FirebaseAuth.instance.currentUser!.email}/products/$ItemId");
  // await desertRef.delete();
}

Stream<QuerySnapshot<Map<String, dynamic>>> ItemsofUser() {
  return FirebaseFirestore.instance
      .collection('user')
      .doc(FirebaseAuth.instance.currentUser?.uid)
      .collection("items")
      // .orderBy("Id", descending: false)
      .snapshots();
}

///Edit Product

Future EditProduct(String PId, String thisisimage, String Ptitle,
    String PDescription, String PCategory, double PPrice) async {
  await FirebaseFirestore.instance
      .collection('user')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection("bussiness")
      .doc("B_${FirebaseAuth.instance.currentUser!.uid}")
      .collection("products")
      .doc(PId)
      .update({
    'Category': PCategory,
    'Price': PPrice,
    'description': PDescription,
    'image': thisisimage,
    'title': Ptitle
  });
}

// Future<String> uploadProductImage(
//   String FileName,
//   String FilePath,
// ) async {
//   File file = File(FilePath);
//   try {
//     FirebaseStorage storage = FirebaseStorage.instance;
//     Reference ref = storage
//         .ref('${FirebaseAuth.instance.currentUser!.email}/profile/')
//         .child(FileName);
//     await ref.putFile(File(FilePath));
//     String imageUrl = await ref.getDownloadURL();
//     return imageUrl;
//   } on firebase_core.FirebaseException catch (e) {
//     print(e);
//   }

//   return '';
// }
