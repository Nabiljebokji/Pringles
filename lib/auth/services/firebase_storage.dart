import 'dart:math';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';

class firebase_storage {
  final storage = FirebaseStorage.instance;

  uploadImage(var imageName, var file) async {
    var storageRef = await storage.ref("images/$imageName");
    await storageRef.putFile(file);
    var Url = await storageRef.getDownloadURL();
    return Url;
  }

  getImagesAndFileNames() async {
    ListResult storageRef = await storage
        .ref("images")
        .listAll(); //list(ListOptions(maxResults: 2) only first 2 results from the list
    storageRef.items.forEach((element) {
      //storageRef.((items)) to get tall the images
      print("================");
      print("image name= ${element.name} , image path= ${element.fullPath}");
      print("================");
    });
    storageRef.prefixes.forEach((element) {
      //storageRef.((prefixes)) to get tall the Filessssss
      print("================");
      print("image name= ${element.name} , image path= ${element.fullPath}");
      print("================");
    });
  }
}
