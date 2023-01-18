import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';

class firemessaging {
  FirebaseMessaging fireMessaging = FirebaseMessaging.instance;
  var token;
  var serverToken =
      "AAAAkLaCQJE:APA91bFaQHig8cG6l5gCXZgAnC0NzklcgQYQu-8ICE1_ckI-0nax-cN69HeJXJq4FR4A8OaoFqxT6dF5jCgbZRzna3MqutN4CbDU6-ou6Dw0cgXoAwgComzTxFycpPqwtl0Fix4OHYkJ";

  sendNotify(String title, String body, String id) async {
    await http.post(
      Uri.parse('https://fcm.googleapis.com/fcm/send'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'key=$serverToken',
      },
      body: jsonEncode(
        <String, dynamic>{
          'notification': <String, dynamic>{
            'body': body.toString(),
            'title': title.toString()
          },
          'priority': 'high',
          'data': <String, dynamic>{
            'click_action': 'FLUTTER_NOTIFICATION_CLICK',
            'id': id.toString(),
            // 'to': "/topic/nabil"
          },
          // 'to': "/topic/nabil"
          'to': await fireMessaging.getToken(),
        },
      ),
    );
  }

  SubscribAndUnSubscrib() async {
    // 'to': "/topic/nabil"
    var subscrib = await fireMessaging.subscribeToTopic("nabil");
    var Unsubscrib = await fireMessaging.unsubscribeFromTopic("nabil");
  }

  getToken() async {
    fireMessaging.getToken().then((token) {
      print("==============token=============");
      print(token);
      print("==============token=============");
    });
  }

  getNotificationWhileUesingApp(BuildContext context) {
    FirebaseMessaging.onMessage.listen((event) {
      print("============message Notification=============");
      print("message from andriod =${event.notification!.android}");
      print("message from IPhone=${event.notification!.apple}");

      print("message title =${event.notification!.title}");
      print("message Body =${event.notification!.body}");

      AwesomeDialog(
          context: context,
          title: "Notification",
          body: Container(
            height: 100,
            child: Column(
              children: [
                Text("You have a new Notification"),
                SizedBox(height: 10),
                Text("${event.notification!.title}"),
                Text("${event.notification!.body}"),
              ],
            ),
          ))
        ..show();
      print("============message Notification=============");
    });
  }

  getNotificationInBackGround() async {
    BackgroundMessage(RemoteMessage message) async {
      print("==================backgroundmessage=============");
      print("${message.notification!.body}");
      print("==================backgroundmessage=============");
    }

    FirebaseMessaging.onBackgroundMessage(BackgroundMessage);
  }

  makeActionWhenMessageComesInBackGround(BuildContext context) async {
    //when the app is not cloesed in the backround and was pressed on
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      if ((event.notification!.body)!.contains("myProducts")) {
        Navigator.of(context).pushNamed("myProducts");
      }
      if ((event.notification!.body)!.contains("profile")) {
        Navigator.of(context).pushNamed("myProfile");
      } else {
        Navigator.of(context).pushNamed("createPringles");
      }
    });
  }

  ifTheAppIsCloesedCompletely(BuildContext context) async {
    var message = await fireMessaging
        .getInitialMessage(); //if the message was pressed save it to message
    if (message != null) {
      //if it was pressed then its not null
      Navigator.of(context).pushNamed("myProducts");
    }
  }

  requestPermissionFor_IOS() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print('User granted provisional permission');
    } else {
      print('User declined or has not accepted permission');
    }
  }
}
