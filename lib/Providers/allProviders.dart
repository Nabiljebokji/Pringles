import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pringless/auth/services/cloudFirestore.dart';

class allProviders extends ChangeNotifier {
  CollectionReference<Map<String, dynamic>> pringlescart =
      FirebaseFirestore.instance.collection("cart");

  double cost = 0.0;
  List pringlesCart = [];

  AddPringlesCart() async {
    QuerySnapshot<Map<String, dynamic>> responsebody = await pringlescart.get();
    responsebody.docs.forEach((element) {
      pringlesCart.add(element.data());
    });
    print(pringlesCart);
   
   
  }

  void add() {
    // cost = cost + pringlesCart[];
    notifyListeners();
  }

  double get totalprice {
    return cost;
  }

  int get count {
    return pringlesCart.length;
  }
}
