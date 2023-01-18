import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:pringless/component/alert.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? get currentUser => _auth.currentUser;
  // final uid = FirebaseAuth.instance.currentUser!.uid;
  late UserCredential userCredential;

  Future<User?> CreateUserOrsignInAnonymously() async {
    if (currentUser == null) {
      await _auth.signInAnonymously();
    }
    return currentUser;
  }

  Future<void> emailVerifiedd() async {
    try {
      print("=============verifing===============");
      await currentUser!.sendEmailVerification();
      print("=============verifing===============");
    } on FirebaseAuthException catch (e) {
      print(e);
    }
  }

  Future<void> logout() async {
    await _auth.signOut();
  }

  Future<UserCredential> createUserWithEmailAndPasswordd({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    var text;
    try {
      userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
        text = "The password provided is too weak.";
        showLoading(context);
        showAlert(context, text);
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
        text = 'The account already exists for that email.';
        showLoading(context);
        AwesomeDialog(
          context: context,
          dialogType: DialogType.error,
          title: "Error",
          body: Container(
              height: 40,
              child: Text("The account already exists for that email.")),
        )..show();
      }
    } catch (e) {
      print(e);
    }
    return userCredential;
  }

  Future<UserCredential> LoginUserWithEmailAndPasswordd({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    var text;

    try {
      showLoading(context);
      userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      print("====================================================");
      print("Email veryfi = ${currentUser!.emailVerified}");
      if (currentUser!.emailVerified == false) {
        emailVerifiedd();
      }
      print("====================================================");
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print("====================================================");
        print("====================================================");
        print('No user found for this Email.');
        text = 'No user found for this Email.';
        Navigator.of(context).pop();
        showAlert(context, text);
        print("====================================================");
        print("====================================================");
      } else if (e.code == 'wrong-password') {
        print("====================================================");
        print("====================================================");
        print('Wrong password provided for thiat user.');
        text = 'Wrong password provided for thiat user.';
        Navigator.of(context).pop();
        showAlert(context, text);
        print("====================================================");
        print("====================================================");
      }
    } catch (e) {
      print("====================================================");
      print("====================================================");
      print(e);
      print("====================================================");
      print("====================================================");
    }

    return userCredential;
  }
}
