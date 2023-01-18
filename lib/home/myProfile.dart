import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pringless/auth/services/authAnonymous.dart';
import 'package:pringless/auth/services/firebase_storage.dart';

class myProfile extends StatefulWidget {
  const myProfile({super.key});

  @override
  State<myProfile> createState() => _myProfileState();
}

class _myProfileState extends State<myProfile> {
  var currentUserUid = AuthService().currentUser!.uid;
  CollectionReference<Map<String, dynamic>> thisuser =
      FirebaseFirestore.instance.collection("users");
  var username;
  var email;
  var phone;
  var gender;

  getuserinformation() async {
    await thisuser
        .where("useruid", isEqualTo: "$currentUserUid")
        .get()
        .then((value) => {
              value.docs.forEach((element) {
                setState(() {
                  username = element.data()["username"];
                  email = element.data()["email"];
                  phone = element.data()["phone"];
                  gender = element.data()["gender"];
                });
              })
            });
  }

  @override
  void initState() {
    getuserinformation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 169, 21, 11),
        title: const Text('My Profile'),
      ),
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.horizontal(
                          left: Radius.circular(50),
                          right: Radius.circular(50),
                        ),
                        border: Border.all(
                            width: 1, color: Color.fromARGB(255, 169, 21, 11)),
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromARGB(255, 169, 21, 11),
                            blurRadius: 3,
                            spreadRadius: 0.2,
                          ),
                        ],
                      ),
                      margin: EdgeInsets.all(10),
                      height: 150,
                      width: 150,
                      child: Center(
                        child: Text("s"),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 40),
                Card(
                  color: Color.fromARGB(255, 169, 21, 11),
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      color: Color.fromARGB(255, 169, 21, 11),
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 169, 21, 11),
                      borderRadius: BorderRadius.horizontal(
                        left: Radius.circular(50),
                        right: Radius.circular(50),
                      ),
                      border: Border.all(
                        width: 1,
                        color: Color.fromARGB(255, 169, 21, 11),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromARGB(255, 169, 21, 11),
                          blurRadius: 2,
                          spreadRadius: 0.2,
                        ),
                      ],
                    ),
                    height: 50,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Container(
                            // color: Colors.white,
                            padding: EdgeInsets.only(left: 10),
                            child: Text("UserName:",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold)),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text("$username",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 5),
                Card(
                  color: Color.fromARGB(255, 169, 21, 11),
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      color: Color.fromARGB(255, 169, 21, 11),
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 169, 21, 11),
                      borderRadius: BorderRadius.horizontal(
                        left: Radius.circular(50),
                        right: Radius.circular(50),
                      ),
                      border: Border.all(
                        width: 1,
                        color: Color.fromARGB(255, 169, 21, 11),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromARGB(255, 169, 21, 11),
                          blurRadius: 2,
                          spreadRadius: 0.2,
                        ),
                      ],
                    ),
                    height: 50,
                    child: Container(
                      padding: EdgeInsets.only(left: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 1,
                            child: Text("Email: ",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold)),
                          ),
                          Expanded(
                            flex: 2,
                            child: Text("$email",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold)),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 5),
                Card(
                  color: Color.fromARGB(255, 169, 21, 11),
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      color: Color.fromARGB(255, 169, 21, 11),
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 169, 21, 11),
                      borderRadius: BorderRadius.horizontal(
                        left: Radius.circular(50),
                        right: Radius.circular(50),
                      ),
                      border: Border.all(
                        width: 1,
                        color: Color.fromARGB(255, 169, 21, 11),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromARGB(255, 169, 21, 11),
                          blurRadius: 2,
                          spreadRadius: 0.2,
                        ),
                      ],
                    ),
                    height: 50,
                    child: Container(
                      padding: EdgeInsets.only(left: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 1,
                            child: Text("Phone: ",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold)),
                          ),
                          Expanded(
                            flex: 2,
                            child: Text("$phone",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold)),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 5),
                Card(
                  color: Color.fromARGB(255, 169, 21, 11),
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      color: Color.fromARGB(255, 169, 21, 11),
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 169, 21, 11),
                      borderRadius: BorderRadius.horizontal(
                        left: Radius.circular(50),
                        right: Radius.circular(50),
                      ),
                      border: Border.all(
                        width: 1,
                        color: Color.fromARGB(255, 169, 21, 11),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromARGB(255, 169, 21, 11),
                          blurRadius: 2,
                          spreadRadius: 0.2,
                        ),
                      ],
                    ),
                    height: 50,
                    child: Container(
                      padding: EdgeInsets.only(left: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 1,
                            child: Text("gender: ",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold)),
                          ),
                          Expanded(
                            flex: 2,
                            child: Text("$gender",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold)),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      height: 40,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 169, 21, 11),
                        borderRadius: BorderRadius.horizontal(
                          left: Radius.circular(50),
                          right: Radius.circular(50),
                        ),
                      ),
                      child: ElevatedButton.icon(
                        label: Text(
                          "Edit Profile",
                          style: TextStyle(fontSize: 14),
                        ),
                        icon: Icon(Icons.edit, size: 16),
                        onPressed: () async {
                          Navigator.of(context).pushNamed("editprofilePosts");
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
