import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:pringless/auth/services/authAnonymous.dart';
import 'package:pringless/component/drawerr.dart';

class cloudFireStore {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  List pringles = [];
  var thisuser = AuthService().currentUser!.uid;

  getDataOld() async {
    CollectionReference<Map<String, dynamic>> usersref =
        firestore.collection("users");
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await usersref.get();

    List<QueryDocumentSnapshot<Map<String, dynamic>>> listDocs =
        querySnapshot.docs;

    listDocs.forEach((element) {
      print("${element.data()}");
    });
  }

  var usernameuid;
  var emailuid;
  userinfo(BuildContext context) async {
    var uids;
    CollectionReference<Map<String, dynamic>> infosRefsh =
        FirebaseFirestore.instance.collection("users");
    await infosRefsh
        .where("useruid", isEqualTo: "${AuthService().currentUser!.uid}")
        .get()
        .then((value) {
      value.docs.forEach((element) {
        usernameuid = element.data()["username"];
        emailuid = element.data()["email"];
        print("%%%%%%%%%%%%%%%%%%%%product%%%%%%%%%%%%%%%%%%%%%%%%");
        print("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%");
        drawer(context, usernameuid, emailuid);
        print(usernameuid);
        print(emailuid);
        print("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%");
        print("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%");
      });
    });
  }

  getDatashort() async {
    CollectionReference<Map<String, dynamic>> usersref =
        firestore.collection("users");

    await usersref.get().then((value) {
      value.docs.forEach((element) {
        print("${element.data()}");
      });
    });
  }

  getDatashortUseingDataSnapshotRealTime() async {
    CollectionReference<Map<String, dynamic>> usersref =
        firestore.collection("users");

    usersref.snapshots().listen((event) {
      event.docs.forEach((element) {
        print("===============");
        print("Age =${element.data()["age"]}");
        print("name =${element.data()["username"]}");
        print("email =${element.data()["email"]}");
        print("===============");
      });
    });
  }

  getOneDocByUId() async {
    DocumentReference<Map<String, dynamic>> doc =
        firestore.collection("5aNF7oEvQ9Vr3a5KzEbL").doc();
    doc.get().then((value) {
      print("${value.data()}");
    });
  }

  getSpecificDocwhere() async {
    CollectionReference<Map<String, dynamic>> specific =
        firestore.collection("users");

    await specific
        .where("age", isGreaterThan: 20)
        .where("languages", arrayContains: "ar")
        .get()
        .then((value) {
      value.docs.forEach((element) {
        print("${element.data()}");
        print("=================");
      });
    });
  }

  getspecificDocFilterwhereIn() async {
    CollectionReference<Map<String, dynamic>> specific =
        firestore.collection("users");
// .where("age", isEqualTo: "2")
    await specific.where("age", whereIn: [20, 50, 100]).get().then((value) {
          value.docs.forEach((element) {
            print("==============");
            print(
                "name =${element.data()["username"]} email = ${element.data()["email"]}");
            print("==============");
          });
        });
  }

  getspecificDocArray() async {
    CollectionReference<Map<String, dynamic>> specific =
        firestore.collection("users");
// .where("languages", arrayContains: "ar")
    await specific
        .where("languages", arrayContainsAny: ["ar", "en"])
        .get()
        .then((value) {
          value.docs.forEach((element) {
            print("===========******============");
            print("${element.data()}");
            print("===========******============");
          });
        });
  }

  getspecificDocwhereOrder() async {
    CollectionReference<Map<String, dynamic>> specific =
        firestore.collection("users");
// .where("languages", arrayContains: "ar")
    await specific
        .where("languages", arrayContainsAny: ["ar", "en"])
        .orderBy("age", descending: false)
        .get()
        .then((value) {
          value.docs.forEach((element) {
            print("===========******============");
            print("${element.data()}");
            print("===========******============");
          });
        });
  }

  AddnewUser() async {
    CollectionReference<Map<String, dynamic>> usersref =
        await firestore.collection("users");

    // usersref.add({//this is without id
    //   "age": 17,
    //   "username": "hani",
    //   "email": "hani@gmail.com",
    //   "phone": 05555555555,
    // });

    usersref.doc("12312344444").set({
      //this is with id
      "age": 17,
      "username": "hani",
      "email": "hani@gmail.com",
      "phone": 05555555555,
    });
  }

  AdduserCredential(username, email, phone) async {
    CollectionReference<Map<String, dynamic>> userRef =
        firestore.collection("users");
    userRef.add({
      "userUid": "$thisuser",
      "username": "$username",
      "email": "$email",
      "phone": "$phone",
    });
  }

  updateUserDoc() async {
    CollectionReference<Map<String, dynamic>> usersref =
        await firestore.collection("users");

    usersref.doc("5aNF7oEvQ9Vr3a5KzEbL").update({
      //with update it will do it without deleting everything
      "age": 24, //the doc url must be valid oreles there will be an error
    }).then((value) {
      print("updated secsessfuly");
    }).catchError((e) {
      print("==============================");
      print("Error is : $e");
      print("==============================");
    });
    // usersref.doc("RWaoTGITywBqzqY07KBo").set({
    //   "age": 17,
    //   "username": "hani",
    // });//with doc.set it will delete everything and add onlly these(overwrite)

    usersref.doc("RWaoTGITaaaaaaaaaaywBqzqY07KBo").set({
      "age":
          17, //with SetOptions(merge: true)); it will work like the updatemethod
      "username":
          "hani", // if the doc url not valid setoptions will create a new doc
    }, SetOptions(merge: true)).then((value) {
      print("updated or created secsessfuly");
    }).catchError((e) {
      print("==============================");
      print("Error is : $e");
      print("==============================");
    });
  }

  DeleteUserDocc() async {
    CollectionReference<Map<String, dynamic>> usersref =
        await firestore.collection("users");

    usersref.doc("RWaoTGITaaaaaaaaaaywBqzqY07KBo").delete().then((value) {
      print("Deleted secsessfuly");
    }).catchError((e) {
      print("==============================");
      print("Error is : $e");
      print("==============================");
    });
  }

  DeleteUserDoc(productId) async {
    CollectionReference<Map<String, dynamic>> usersref =
        await firestore.collection("pringles");

    usersref.doc(productId).delete().then((value) {
      print("Deleted secsessfuly");
    }).catchError((e) {
      print("==============================");
      print("Error is : $e");
      print("==============================");
    });
  }

  updatetransaction() async {
    DocumentReference<Map<String, dynamic>> transUsers =
        await firestore.collection("users").doc("RWaoTGITywBqzqY07KBo");

    firestore.runTransaction((transaction) async {
      DocumentSnapshot dsnapshot = await transaction.get(transUsers);

      if (dsnapshot.exists) {
        transaction.update(transUsers, {
          "age": 23,
        });
      } else {
        print("the transaction has failed");
      }
    });
  }

  batchWrite() async {
    DocumentReference<Map<String, dynamic>> docone =
        await firestore.collection("users").doc("RWaoTGITywBqzqY07KBo");

    DocumentReference<Map<String, dynamic>> doctwo =
        await firestore.collection("users").doc("12312344444");

    WriteBatch batch = firestore.batch();
    batch.set(docone, {
      "age": 44,
      "username": "khaled",
      "email": "khaled@gmail.com",
      "phone": 02222222,
    });

    batch.delete(doctwo);
    batch.commit();
  }

  AddPringles(name, size, price, image, useruid) async {
    CollectionReference<Map<String, dynamic>> pringlesRef =
        await FirebaseFirestore.instance.collection("pringles");
    QuerySnapshot<Map<String, dynamic>> responsebody = await pringlesRef.get();

    pringlesRef
        .doc()
        .set({
          "cost": "$price",
          "flavorName": "$name",
          "image": "$image",
          "size": "$size",
          "useruid": "$useruid",
        })
        .then((value) => {})
        .catchError((e) {
          print("**************ERROR******************");
          print(e);
          print("**************ERROR******************");
        });
    ;
  }

  AddPringlesCart(name, size, price, image) async {
    CollectionReference<Map<String, dynamic>> pringlesRef =
        await FirebaseFirestore.instance.collection("cart");
    QuerySnapshot<Map<String, dynamic>> responsebody = await pringlesRef.get();

    pringlesRef
        .doc()
        .set({
          "cost": "$price",
          "flavorName": "$name",
          "image": "$image",
          "size": "$size",
        })
        .then((value) => {})
        .catchError((e) {
          print("**************ERROR******************");
          print(e);
          print("**************ERROR******************");
        });
    ;
  }

  AddPringlesCartCount() async {
    CollectionReference<Map<String, dynamic>> pringlesRef =
        await FirebaseFirestore.instance.collection("cart");
    QuerySnapshot<Map<String, dynamic>> responsebody = await pringlesRef.get();

    return pringlesRef.count();
  }

  updatePringlesNoImage(name, size, price, useruid, docid) async {
    CollectionReference<Map<String, dynamic>> pringlesRef =
        await FirebaseFirestore.instance.collection("pringles");
    QuerySnapshot<Map<String, dynamic>> responsebody = await pringlesRef.get();

    pringlesRef
        .doc(docid)
        .update({
          "cost": "$price",
          "flavorName": "$name",
          "size": "$size",
          "useruid": "$useruid",
        })
        .then((value) => {})
        .catchError((e) {
          print("**************ERROR******************");
          print(e);
          print("**************ERROR******************");
        });
  }

  updatePringlesImage(docid, image) async {
    CollectionReference<Map<String, dynamic>> pringlesRef =
        await FirebaseFirestore.instance.collection("pringles");
    QuerySnapshot<Map<String, dynamic>> responsebody = await pringlesRef.get();
    pringlesRef
        .doc(docid)
        .update({
          "image": "$image",
        })
        .then((value) => {})
        .catchError((e) {
          print("**************ERROR******************");
          print(e);
          print("**************ERROR******************");
        });
  }
}
