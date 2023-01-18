// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, prefer_typing_uninitialized_variables, camel_case_types

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pringless/Providers/allProviders.dart';
import 'package:pringless/auth/services/authAnonymous.dart';
import 'package:pringless/auth/services/cloudFirestore.dart';
import 'package:pringless/auth/services/firebaseMessaging.dart';
import 'package:pringless/component/drawerr.dart';
import 'package:provider/provider.dart';

class homepage extends StatefulWidget {
  const homepage({super.key});

  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  late UserCredential userCredential;
  var username = AuthService().currentUser!.displayName;
  var useremail = AuthService().currentUser!.email;
  List myProfileInfo = [];
  Query<Map<String, dynamic>> infosRef = FirebaseFirestore.instance
      .collection("users")
      .where("useruid", isEqualTo: "${AuthService().currentUser!.uid}");

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
        print("%%%%%%%%%%%%%%%%%%%%home%%%%%%%%%%%%%%%%%%%%%%%%");
        print("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%");
        drawer(context, usernameuid, emailuid);
        print(usernameuid);
        print(emailuid);
        print("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%");
        print("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%");
      });
    });
  }

  List pringless = [
    {
      "name": "BBQ",
      "size": "BBQ",
      "cost": "big",
      "image": "images/1.jpg",
    },
  ];
  List pringles = [];
  List pringlesCart = [];

  CollectionReference<Map<String, dynamic>> pringlesRef =
      FirebaseFirestore.instance.collection("pringles");
  CollectionReference<Map<String, dynamic>> pringlescartRef =
      FirebaseFirestore.instance.collection("cart");

  AddPringles() async {
    QuerySnapshot<Map<String, dynamic>> responsebody = await pringlesRef.get();
    responsebody.docs.forEach((element) {
      setState(() {
        pringles.add(element.data());
      });
    });

    print(pringles);
  }

  AddPringlesCart() async {
    QuerySnapshot<Map<String, dynamic>> responsebody =
        await pringlescartRef.get();
    responsebody.docs.forEach((element) {
      setState(() {
        pringlesCart.add(element.data());
      });
    });

    print(pringles);
  }

  getUser() async {
    print("==========================");
    var userCredential = await AuthService().currentUser;
    print(userCredential);
    print("==========================");
  }

  @override
  void initState() {
    getuserID();
    firemessaging().getToken();
    // firemessaging().getNotificationWhileUesingApp(context);
    // firemessaging().getNotificationInBackGround();
    // firemessaging().makeActionWhenMessageComesInBackGround(context);
    // firemessaging().ifTheAppIsCloesedCompletely(context);
    // firemessaging().sendNotify("hello", "welcome", "3");
    // firemessaging().getNotificationWhileUesingApp(context);
    AddPringlesCart();
    AddPringles();
    getUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text("Home Page"),
        actions: [
          Row(
            children: [
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.add_shopping_cart),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Consumer<allProviders>(
                  builder: (context, cart, child) {
                    return Text("${cart.count}");
                  },
                ),
              ),
            ],
          ),
        ],
      ),
      drawer: myProfileInfo == null
          ? CircularProgressIndicator()
          : drawer(context, usernameuid, emailuid),
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
                  child: bodyshape(pringles: snapshot.data!.docs[index].data()),
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
  final pringles;
  const bodyshape({super.key, this.pringles});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          Card(
            child: Column(
              children: [
                Center(
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    height: 110,
                    width: 110,
                    child: Image.network("${pringles["image"]}",
                        fit: BoxFit.contain),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(" Name:"),
                    Text("${pringles["flavorName"]}"),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(" Size: "),
                    Text("${pringles["size"]}"),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(" price:"),
                    Text("${pringles["cost"]}"),
                  ],
                ),
              ],
            ),
          ),
          Container(
            child: Consumer<allProviders>(
              builder: (context, value, child) {
                return IconButton(
                  onPressed: () {
                    value.add();
                    cloudFireStore().AddPringlesCart(
                      pringles["flavorName"],
                      pringles["cost"],
                      pringles["size"],
                      pringles["image"],
                    );
                    print("=================");
                    print(pringles);
                  },
                  icon: Icon(Icons.add),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
