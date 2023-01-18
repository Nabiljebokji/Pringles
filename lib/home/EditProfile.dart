import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pringless/auth/services/authAnonymous.dart';
import 'package:pringless/auth/services/cloudFirestore.dart';

class editProfilePosts extends StatefulWidget {
  const editProfilePosts({super.key});

  @override
  State<editProfilePosts> createState() => _editProfilePostsState();
}

class _editProfilePostsState extends State<editProfilePosts> {
  GlobalKey<FormState> formstate = new GlobalKey<FormState>();
  TextEditingController myusernameController = TextEditingController();
  TextEditingController myEmailController = TextEditingController();
  TextEditingController mygenderController = TextEditingController();
  TextEditingController myphoneController = TextEditingController();
  var myusername;
  var myEmail;
  var mygender;
  var myphone;

  DocumentReference<Map<String, dynamic>> userinfo = cloudFireStore()
      .firestore
      .collection("users")
      .doc("${AuthService().currentUser!.uid}");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 169, 21, 11),
        title: const Text('Edit Profile'),
      ),
      body: ListView(
        children: [
          Form(
            child: Container(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          AwesomeDialog(
                              dialogType: DialogType.question,
                              context: context,
                              title: "Change Image ?",
                              body: Container(
                                height: 100,
                                child: Column(
                                  children: [
                                    Text(
                                      "Change Image ?",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    SizedBox(height: 15),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        ElevatedButton(
                                          child: Text(
                                            "Yes",
                                            style: TextStyle(fontSize: 14),
                                          ),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                        ElevatedButton(
                                          child: Text(
                                            "No",
                                            style: TextStyle(fontSize: 14),
                                          ),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ))
                            ..show();
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.horizontal(
                              left: Radius.circular(50),
                              right: Radius.circular(50),
                            ),
                            border: Border.all(width: 1, color: Colors.grey),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black,
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
                      ),
                    ],
                  ),
                  SizedBox(height: 40),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 5),
                    child: TextFormField(
                      controller: myusernameController,
                      onSaved: (newValue) {
                        myusername = newValue;
                      },
                      validator: (value) {
                        if (value!.length < 2) {
                          return "UserName must be more han 2 charters";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        label: Text("UserName"),
                        labelStyle:
                            TextStyle(color: Color.fromARGB(255, 169, 21, 11)),
                        prefixIcon: Icon(Icons.person,
                            color: Color.fromARGB(255, 169, 21, 11)),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 169, 21, 11),
                              width: 2),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: Colors.grey, width: 2),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 5),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 5),
                    child: TextFormField(
                      controller: myEmailController,
                      onSaved: (newValue) {
                        myEmail = newValue;
                      },
                      validator: (value) {
                        if (value!.contains("@")) {
                          return null;
                        }
                        return "Please Enter a valid Email";
                      },
                      decoration: InputDecoration(
                        label: Text("Email"),
                        labelStyle:
                            TextStyle(color: Color.fromARGB(255, 169, 21, 11)),
                        prefixIcon: Icon(Icons.email,
                            color: Color.fromARGB(255, 169, 21, 11)),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 169, 21, 11),
                              width: 2),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: Colors.grey, width: 2),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 5),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 5),
                    child: TextFormField(
                      controller: myphoneController,
                      onSaved: (newValue) {
                        myphone = newValue;
                      },
                      validator: (value) {
                        if (value!.length < 6) {
                          return "Plese Enter a valid phone number";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        label: Text("Phone Number"),
                        labelStyle:
                            TextStyle(color: Color.fromARGB(255, 169, 21, 11)),
                        prefixIcon: Icon(Icons.phone,
                            color: Color.fromARGB(255, 169, 21, 11)),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 169, 21, 11),
                              width: 2),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: Colors.grey, width: 2),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 5),
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
                        child: ElevatedButton(
                          child: Text(
                            "Save Changes",
                            style: TextStyle(fontSize: 14),
                          ),
                          onPressed: () async {
                            Navigator.of(context)
                                .pushReplacementNamed("homepage");
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
