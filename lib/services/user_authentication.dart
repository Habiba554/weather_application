import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/constants/app_localization.dart';
import 'package:weather_app/constants/app_routes.dart';
import 'package:weather_app/constants/app_strings.dart';
import 'package:weather_app/providers/user_provider.dart';
import 'package:weather_app/views/widgets/snack_bar.dart';
import '../main.dart';

class UserAuthentication {
  final auth = FirebaseAuth.instance;
  final firebaseMessaging = FirebaseMessaging.instance;

  Future<void> loginUser(
      BuildContext context, String emailAddress, String password) async {
    try {
      
      UserCredential userCredential= await auth.signInWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      String userId = userCredential.user!.uid;
      Provider.of<UserProvider>(context, listen: false).setUserId(userId);
      Navigator.pushNamed(context, Routes.homeRoute);
    } on FirebaseAuthException catch (e) {
      if (e.code == "invalid-credential") {
        showSnackBars(msg: context.translate(AppStrings.wrongEmailOrPassword),context);
      }
    } catch (ex) {
      showSnackBars(msg: ex.toString(),context);
      
    }
  }

  Future<void> registerUser(
      BuildContext context, String emailAddress, String password) async {
    try {
      await auth.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        showSnackBars(msg: context.translate(AppStrings.weakPassword),context);
      } else if (e.code == 'email-already-in-use') {
        showSnackBars(msg: context.translate(AppStrings.accountExistsForEmail),context);
      }
    } catch (ex) {
      showSnackBars(msg: ex.toString(),context);
    }
  }

  Future<void> initNotifications() async {
  

      NotificationSettings settings = await firebaseMessaging.requestPermission(
    alert: true,
    badge: true,
    sound: true,
  );

  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    // print('User granted permission');
  } else if (settings.authorizationStatus == AuthorizationStatus.denied) {
    // print('User denied permission');
  } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
    // print('User granted provisional permission');
  }
    String? fCMToken = await firebaseMessaging.getToken();
    print(fCMToken.toString());
    handleBackgroundMssageNotification();
  }

  void handleMssageNotification(RemoteMessage? messageNotification){
   
   if(messageNotification==null)return;
   navigatorKey.currentState?.pushNamed(Routes.homeRoute);
  }

   Future handleBackgroundMssageNotification()async{
   firebaseMessaging.getInitialMessage().then(handleMssageNotification );
   FirebaseMessaging.onMessageOpenedApp.listen(handleMssageNotification );
  }
}
