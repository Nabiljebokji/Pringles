import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pringless/auth/services/authAnonymous.dart';
import 'package:pringless/home/myProfile.dart';

drawer(context, username, email) {
  var emailuser = email;
  // email = myProfileInfo[0]["email"];
  var name = username;
  // username = myProfileInfo[0]["username"];
  return Drawer(
    child: ListView(
      padding: EdgeInsets.all(0),
      children: [
        Container(
          color: Color.fromARGB(255, 169, 21, 11),
          height: 260,
          padding: EdgeInsets.only(left: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 100, 0, 10),
                    padding: EdgeInsets.all(20),
                    height: 80,
                    width: 80,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.horizontal(
                        left: Radius.circular(100),
                        right: Radius.circular(100),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        "A",
                        style: TextStyle(
                          fontSize: 30,
                        ),
                      ),
                    ),
                  ),
                  //Text
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    name == null ? " " : "${name}",
                    style: TextStyle(fontSize: 17, color: Colors.white),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    emailuser == null ? " " : "${emailuser}",
                    style: TextStyle(fontSize: 17, color: Colors.white),
                  ),
                ],
              ),
            ],
          ),
        ),
        ListTile(
          leading: const Icon(Icons.home),
          title: const Text('Home'),
          onTap: () {
            Navigator.of(context).pushNamed("homepage");
          },
        ),
        ListTile(
          leading: const Icon(Icons.person),
          title: const Text(' My Profile '),
          onTap: () {
            Navigator.of(context).pushNamed("myProfile");
          },
        ),
        ListTile(
          leading: const Icon(Icons.book),
          title: const Text(' My Products '),
          onTap: () {
            Navigator.of(context).pushNamed("myProducts");
          },
        ),
        ListTile(
          leading: const Icon(Icons.workspace_premium),
          title: const Text(' Go Premium '),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        ListTile(
          leading: const Icon(Icons.edit),
          title: const Text(' Edit Profile '),
          onTap: () {
            Navigator.of(context).pushNamed("editprofilePosts");
          },
        ),
        ListTile(
          leading: const Icon(Icons.logout),
          title: const Text('LogOut'),
          onTap: () async {
            await AuthService().logout();
            Navigator.of(context).pushReplacementNamed("login");
          },
        ),
      ],
    ),
  ); //Deawer
}
