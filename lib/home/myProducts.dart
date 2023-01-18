// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, prefer_typing_uninitialized_variables, camel_case_types

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pringless/auth/services/authAnonymous.dart';
import 'package:pringless/auth/services/cloudFirestore.dart';
import 'package:pringless/auth/services/firebase_storage.dart';
import 'package:pringless/component/drawerr.dart';
import 'package:pringless/curd/editMyProduct.dart';
import 'package:pringless/curd/viewProduct.dart';

class myProducts extends StatefulWidget {
  const myProducts({super.key});

  @override
  State<myProducts> createState() => _myProductsState();
}

class _myProductsState extends State<myProducts> {
  late UserCredential userCredential;
  var username = AuthService().currentUser!.displayName;
  var useremail = AuthService().currentUser!.email;
  var userUid = AuthService().currentUser!.uid;
  var userdoc = cloudFireStore().firestore.collection("users").doc();

  List mypringles = [];
  Query<Map<String, dynamic>> pringlesRef = FirebaseFirestore.instance
      .collection("pringles")
      .where("useruid", isEqualTo: "${AuthService().currentUser!.uid}");

  Query<Map<String, dynamic>> infosRef = FirebaseFirestore.instance
      .collection("users")
      .where("useruid", isEqualTo: "${AuthService().currentUser!.uid}");
  List myProfileInfo = [];

  AddPringles() async {
    QuerySnapshot<Map<String, dynamic>> responsebody = await pringlesRef.get();
    responsebody.docs.forEach((element) {
      setState(() {
        mypringles.add(element.data());
      });
    });

    print(mypringles);
  }

  AddProfileInfo() async {
    QuerySnapshot<Map<String, dynamic>> responsebody = await infosRef.get();
    responsebody.docs.forEach((element) {
      setState(() {
        myProfileInfo.add(element.data());
      });
    });
    print("=pppppppppppppppppppppppppppppppppppppppppppppppppp");
    print(myProfileInfo);
  }

  getUser() async {
    print("==========================");
    var userCredential = await AuthService().currentUser;
    print(userCredential);
    print("==========================");
  }

  var usernameuid;
  var emailuid;
  getuserID() async {
    var uids;
    Query<Map<String, dynamic>> infosRefs =
        FirebaseFirestore.instance.collection("users");
    await infosRefs
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

  @override
  void initState() {
    AddPringles();
    getuserID();
    AddProfileInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text("My Products"),
      ),
      drawer: drawer(context, usernameuid, emailuid),
      // drawer(context, myProfileInfo),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () {
          Navigator.of(context).pushNamed("createPringles");
        },
        child: Icon(Icons.add),
      ),
      body: FutureBuilder(
        // StreamBuilder(
        //stream: pringlesRef.snapshots(),
        future: pringlesRef.get(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                return Dismissible(
                  key: Key("$index"),
                  child: bodyshape(
                      mypringles: snapshot.data!.docs[index].data(),
                      productId: snapshot.data!.docs[index].id),
                );
              },
            );
          }
          if (snapshot.hasError) {
            AwesomeDialog(
                context: context,
                title: "Error",
                body: Container(
                  height: 20,
                  child: Text("Error was happend"),
                ))
              ..show();
          }

          return Center(child: Container(child: CircularProgressIndicator()));
        },
      ),
    );
  }
}

class bodyshape extends StatelessWidget {
  final mypringles;
  final productId;

  const bodyshape({super.key, this.mypringles, this.productId});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) {
                  return viewProduct(
                    list: mypringles,
                  );
                },
              ));
            },
            child: Card(
              child: Column(
                children: [
                  Center(
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      height: 110,
                      width: 110,
                      child: Image.network("${mypringles["image"]}",
                          fit: BoxFit.contain),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(" Name:"),
                      Text("${mypringles["flavorName"]}"),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(" Size: "),
                      Text("${mypringles["size"]}"),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(" price:"),
                      Text("${mypringles["cost"]}"),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Column(
            children: [
              IconButton(
                onPressed: () async {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) {
                      return editMyProduct(
                        productId: productId,
                        list: mypringles,
                      );
                    },
                  ));
                },
                icon: Icon(Icons.edit),
              ),
              IconButton(
                onPressed: () async {
                  AwesomeDialog(
                      context: context,
                      title: "Delete",
                      body: Container(
                        height: 200,
                        child: Column(
                          children: [
                            Text(
                                "Are you sure you want to delete this product ?"),
                            SizedBox(height: 30),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(" Name:"),
                                    Text("${mypringles["flavorName"]}"),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(" Size: "),
                                    Text("${mypringles["size"]}"),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(" price:"),
                                    Text("${mypringles["cost"]}"),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    IconButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        icon: Icon(Icons.cancel)),
                                    IconButton(
                                        onPressed: () {
                                          cloudFireStore()
                                              .DeleteUserDoc(productId);
                                          Navigator.of(context)
                                              .pushNamed("myProducts");
                                        },
                                        icon: Icon(Icons.upgrade_rounded)),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ))
                    ..show();
                },
                icon: Icon(Icons.delete),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
