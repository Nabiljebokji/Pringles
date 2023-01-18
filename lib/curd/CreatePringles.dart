// ignore_for_file: prefer_const_constructors

import 'dart:io';
import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as Path;
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:pringless/auth/services/authAnonymous.dart';
import 'package:pringless/auth/services/cloudFirestore.dart';
import 'package:pringless/auth/services/firebase_storage.dart';

class CreatePringles extends StatefulWidget {
  const CreatePringles({super.key});

  @override
  State<CreatePringles> createState() => _CreatePringlesState();
}

class _CreatePringlesState extends State<CreatePringles> {
  GlobalKey<FormState> formState = new GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController sizeController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  late File file;

  ImagePicker imagePicker = ImagePicker();
  var ImageURL;
  var imageName;
  var imagepath;
  late bool imagepickedd = false;
  var useruid;

  uploadImage(PickedFile? imagepicked) async {
    if (imagepicked != null) {
      imagepickedd = true;
      file = File(imagepicked.path);
      imageName = Path.basename(imagepicked.path);
      var random = Random().nextInt(10000000);
      imageName = "$random$imageName";
      // ImageURL = await firebase_storage().uploadImage(imageName, file);
      imagepath = imagepicked.path;
      firebase_storage().getImagesAndFileNames();
      print("=================================");
      print(imageName);
      print("=================================");
      print(imagepicked.path);
      print("=================================");
      print(ImageURL);
      print("=================================");
    } else {
      imagepickedd = false;
      AwesomeDialog(
          context: context,
          title: "Error",
          body: Container(
            height: 30,
            child: Text("please choose an image"),
          ));
      print("=================================");
      print("please pick an image");
      print("=================================");
    }
  }

  saveData() async {
    var formdata = formState.currentState;
    if (imagepickedd == false) {
      return AwesomeDialog(
          context: context,
          title: "Error",
          body: Container(height: 30, child: Text("Please enter an image!")))
        ..show();
    }
    if (formdata!.validate()) {
      formdata.save();
      ImageURL = await firebase_storage().uploadImage(imageName, file);
      print("=================================");
      print(ImageURL);
      print("=================================");
      useruid = await AuthService().currentUser!.uid;
      cloudFireStore().AddPringles(
          nameController.text.trim(),
          sizeController.text.trim(),
          priceController.text.trim(),
          ImageURL,
          useruid);
      print("================================");
      print("Product has been saved");
      print("================================");
    } else {
      AwesomeDialog(
          context: context,
          title: "Error",
          body: Container(height: 30, child: Text("Somthing went wrong!")))
        ..show();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text("Create New Product"),
      ),
      body: ListView(children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Form(
                key: formState,
                child: Column(
                  children: [
                    SizedBox(height: 20),
                    TextFormField(
                      controller: nameController,
                      validator: (value) {
                        if (value!.length < 20) {
                          return null;
                        }
                        return "Name must be less than 20 characters";
                      },
                      decoration: InputDecoration(
                        label: Text("Product Name"),
                        prefixIcon:
                            Icon(Icons.card_giftcard, color: Colors.red),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: Colors.red, width: 2),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: Colors.black, width: 2),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: Colors.red, width: 2),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: sizeController,
                      validator: (value) {
                        if (value!.length < 10) {
                          return null;
                        }
                        return "Name must not be more than 10 characters";
                      },
                      maxLength: 20,
                      decoration: InputDecoration(
                        label: Text("Product Size"),
                        prefixIcon: Icon(Icons.soup_kitchen_outlined,
                            color: Colors.red),
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
                    SizedBox(height: 5),
                    TextFormField(
                      controller: priceController,
                      validator: (value) {
                        if (value!.length < 10) {
                          return null;
                        }
                        return "Name must not be more than 10 characters";
                      },
                      maxLength: 20,
                      decoration: InputDecoration(
                        label: Text("Product Price"),
                        prefixIcon: Icon(Icons.monetization_on_rounded,
                            color: Colors.red),
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
                    Row(
                      children: [
                        ElevatedButton.icon(
                          onPressed: () {
                            showBottomSheet();
                          },
                          icon: Icon(Icons.image),
                          label: Text("Add Image"),
                        ),
                      ],
                    ),
                    SizedBox(height: 50),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton.icon(
                          onPressed: () async {
                            await saveData();
                            AwesomeDialog(
                                context: context,
                                dialogType: DialogType.success,
                                title: "Product has been Saved",
                                body: Container(
                                    height: 80,
                                    child: Column(
                                      children: [
                                        Text("Product has been Saved"),
                                        ElevatedButton(
                                          onPressed: () {
                                            Navigator.of(context)
                                                .pushNamed("homepage");
                                          },
                                          child: Text("Ok"),
                                        ),
                                      ],
                                    )))
                              ..show();
                          },
                          icon: Icon(Icons.save),
                          label: Text("Save Changes"),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }

  showBottomSheet() {
    return showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          height: 150,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                "Please Choose Image:",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InkWell(
                    onTap: () async {
                      PickedFile? imagepicked = await imagePicker.getImage(
                          source: ImageSource.camera);
                      uploadImage(imagepicked);
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      height: 60,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Icon(Icons.camera),
                          Text(
                            "From Camera",
                            style: TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      PickedFile? imagepicked = await imagePicker.getImage(
                          source: ImageSource.gallery);
                      uploadImage(imagepicked);
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      height: 60,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Icon(Icons.photo_outlined),
                          Text(
                            "From Gallery",
                            style: TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
