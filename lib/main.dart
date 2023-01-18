import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pringless/auth/login.dart';
import 'package:pringless/auth/signup.dart';
import 'package:pringless/curd/CreatePringles.dart';
import 'package:pringless/curd/editMyProduct.dart';
import 'package:pringless/curd/viewProduct.dart';
import 'package:pringless/home/EditProfile.dart';
import 'package:pringless/home/homePage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:pringless/home/myProducts.dart';
import 'package:pringless/home/myProfile.dart';
import 'package:provider/provider.dart';
import 'Providers/allProviders.dart';
import 'firebase_options.dart';

bool? loginOrNot;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // isLogedin();

  // await AuthService().CreateUserOrsignInAnonymously();
  // await cloudFireStore().getSpecificDoc();
  // await cloudFireStore().getDatashort();
  // await cloudFireStore().getspecificDocFilter();
  // await cloudFireStore().getspecificDocArray();
  // await cloudFireStore().getSpecificDocwhere();
  // await cloudFireStore().getDatashortUseingDataSnapshotRealTime();
  // await cloudFireStore().AddnewUser();
  // await cloudFireStore().updateUserDoc();
  // await cloudFireStore().DeleteUserDoc();
  // await cloudFireStore().updatetransaction();
  // await cloudFireStore().batchWrite();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    isLogedin();
    super.initState();
  }

  isLogedin() async {
    var loged = await FirebaseAuth.instance.currentUser;
    if (loged == null) {
      loginOrNot = false;
    } else {
      loginOrNot = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => allProviders(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: loginOrNot == false ? Login() : homepage(),
        // home: StreamBuilder<User?>(
        //   stream: AuthService().userChanged,
        //   builder: (BuildContext context, AsyncSnapshot snapshot) {
        //     return snapshot.data != null ? homepage() : Login();
        //   },
        theme: ThemeData(
          primaryColor: Color.fromARGB(255, 169, 21, 11),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: Color.fromARGB(255, 169, 21, 11), // Button color
              foregroundColor: Colors.white, // Text color
            ),
          ),
        ),
        routes: {
          "login": (context) => Login(),
          "signup": (context) => Signup(),
          "homepage": (context) => homepage(),
          "createPringles": (context) => CreatePringles(),
          "myProfile": (context) => myProfile(),
          "editprofilePosts": (context) => editProfilePosts(),
          "myProducts": (context) => myProducts(),
          "editMyProduct": (context) => editMyProduct(),
          "viewProduct": (context) => viewProduct(),
        },
      ),
    );
  }
}
// SHA1: a5:21:3b:eb:8e:c1:ec:10:29:7d:ed:02:0a:c7:2c:f2:27:4a:96:ce
//  SHA256: DD:8F:0B:4F:F9:D7:D1:0B:94:50:64:E9:8F:5F:A8:34:6A:D4:C2:B3:EB:57:77:D0:2D:4C:B9:C5:F1:AE:4F:C5

// web       1:621537280145:web:457e7c0e50b6fd821abf30
// android   1:621537280145:android:20c3215928ded9091abf30
// ios       1:621537280145:ios:212d944b42da955f1abf30
// macos     1:621537280145:ios:212d944b42da955f1abf30

// org.gradle.jvmargs=-Xmx1536M