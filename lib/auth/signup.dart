import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pringless/auth/services/authAnonymous.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:pringless/auth/services/cloudFirestore.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  late UserCredential userCredential;
  GlobalKey<FormState> formState = new GlobalKey<FormState>();
  var myusername;
  var myEmail;
  var myphone;
  var mypassword;
  TextEditingController myusernameController = TextEditingController();
  TextEditingController myEmailController = TextEditingController();
  TextEditingController myphoneController = TextEditingController();
  TextEditingController mypasswordController = TextEditingController();

  SignUp(context) async {
    var formData = formState.currentState;
    if (formData!.validate()) {
      formData.save();
      print(
          "==================this is signin Email and password===============");
      try {
        userCredential = await AuthService().createUserWithEmailAndPasswordd(
            context: context,
            email: myEmailController.text.toLowerCase().trim(),
            password: mypasswordController.text.trim());
      } catch (e) {
        print("@@@@@@$e");
      }

      print("userCredential = ${AuthService().currentUser}");
      print(
          "==================this is signin Email and password===============");
    } else {}
    return userCredential;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: Form(
            key: formState,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 20),
                Center(
                  child: Container(
                    height: 300,
                    child: Image.asset("images/logo.jpeg"),
                  ),
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
                        return "UserName must be more than 2 characters";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: "UserName",
                      prefixIcon: Icon(Icons.person, color: Colors.grey),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(color: Colors.red, width: 2),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(color: Colors.black, width: 2),
                      ),
                    ),
                  ),
                ),
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
                      return "Email is not valid";
                    },
                    decoration: InputDecoration(
                      hintText: "Email",
                      prefixIcon: Icon(Icons.email, color: Colors.grey),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(color: Colors.red, width: 2),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(color: Colors.black, width: 2),
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  child: TextFormField(
                    controller: myphoneController,
                    onSaved: (newValue) {
                      myphone = newValue;
                    },
                    validator: (value) {
                      if (value!.length < 9) {
                        return "Phone Number not valid";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: "Phone",
                      prefixIcon: Icon(Icons.phone, color: Colors.grey),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(color: Colors.red, width: 2),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(color: Colors.black, width: 2),
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  child: TextFormField(
                    controller: mypasswordController,
                    onSaved: (newValue) {
                      mypassword = newValue;
                    },
                    validator: (value) {
                      if (value!.length < 6) {
                        return "Password is not strong enough";
                      }
                      return null;
                    },
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: "PassWord",
                      prefixIcon: Icon(Icons.lock_open, color: Colors.grey),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(color: Colors.red, width: 2),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(color: Colors.black, width: 2),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 5),
                Row(
                  children: [
                    Text("I have an account."),
                    InkWell(
                      child: Text(
                        "Click here.",
                        style: TextStyle(color: Colors.blue),
                      ),
                      onTap: () {
                        Navigator.of(context).pushNamed("login");
                      },
                    ),
                  ],
                ),
                SizedBox(height: 30),
                Container(
                  height: 35,
                  width: 160,
                  child: ElevatedButton(
                    onPressed: () async {
                      userCredential = await SignUp(context);

                      if (userCredential != null) {
                        cloudFireStore()
                            .AdduserCredential(myusername, myEmail, myphone);
                        Navigator.of(context).pushReplacementNamed("homepage");
                        // await SigninWithGoogle();
                      } else {
                        print("failed to signin");
                      }
                    },
                    child: Text(
                      "Sign in",
                      style: TextStyle(fontSize: 22),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
