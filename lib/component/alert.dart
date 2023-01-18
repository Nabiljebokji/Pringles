import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

showLoading(context) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Please wait.."),
          content: Container(
              height: 30, child: Center(child: CircularProgressIndicator())),
        );
      });
}

showAlert(context, text) {
  AwesomeDialog(
    context: context,
    dialogType: DialogType.error,
    title: "Error",
    body: Container(height: 40, child: Text(text)),
  )..show();
}
