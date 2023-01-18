import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pringless/auth/services/authAnonymous.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  GlobalKey<FormState> formdata = new GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  late UserCredential userCredential;

  LoginUser(context) async {
    var formData = formState.currentState;
    if (formData!.validate()) {
      formData.save();
      print(
          "==================this is LOGIN Email and password===============");
      userCredential = await AuthService().LoginUserWithEmailAndPasswordd(
          context: context,
          email: emailController.text.toLowerCase().trim(),
          password: passwordController.text.trim());
      print("====================================================");
      print("Email veryfi = ${AuthService().currentUser!.emailVerified}");
      if (AuthService().currentUser!.emailVerified == false) {
        await AuthService().emailVerifiedd();
      }
      print("====================================================");
      print("userCredential = $userCredential");
      print(
          "==================this is LOGIN Email and password===============");
      return userCredential;
    } else {}
  }

  Future<void> SigninWithGoogle() async {
    print("==================this is start SigninWith Google===============");
    try {
      final GoogleSignInAccount? googleuser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth =
          await googleuser?.authentication;

      if (googleAuth?.accessToken != null && googleAuth?.idToken != null) {
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken,
          idToken: googleAuth?.idToken,
        );
        UserCredential userCredential =
            await FirebaseAuth.instance.signInWithCredential(credential);
      }
    } on FirebaseAuthException catch (e) {
      print("@@@@@@@@@@@@@@@@@@@$e");
    }
    print("====================================================");
    print("userCredential = ${AuthService().currentUser}");
    print("==================this is  end SigninWith Google===============");
  }

  void anonymouslySignin() async {
    print(
        "=================start=====anonymouslySignin==========================");
    print("User info = ${await AuthService().CreateUserOrsignInAnonymously()}");
    User? userr;
    userr = await AuthService().CreateUserOrsignInAnonymously();
    print(userr);
    print(
        "=================end=====anonymouslySignin==========================");
  }

  GlobalKey<FormState> formState = new GlobalKey<FormState>();
  var myEmail;
  var mypassword;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 70),
          child: Form(
            key: formState,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Container(
                    height: 300,
                    color: Colors.red,
                    child: Image.asset("images/logo.jpeg"),
                  ),
                ),
                SizedBox(height: 40),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  child: TextFormField(
                    controller: emailController,
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
                    controller: passwordController,
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
                    Text("Don't have an account?"),
                    InkWell(
                      child: Text(
                        "Click here.",
                        style: TextStyle(color: Colors.blue),
                      ),
                      onTap: () {
                        Navigator.of(context).pushReplacementNamed("signup");
                      },
                    ),
                  ],
                ),
                SizedBox(height: 30),
                Container(
                  height: 35,
                  width: 160,
                  child: ElevatedButton(
                    // style: ElevatedButton.styleFrom(
                    //   backgroundColor: Color.fromARGB(255, 169, 21, 11),
                    // ),
                    onPressed: () async {
                      //await anonymouslySignin();

                      userCredential = await LoginUser(context);
                      if (userCredential != null) {
                        Navigator.of(context).pushReplacementNamed("homepage");
                      }
                    },
                    child: Text(
                      "Login",
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
