import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:twitter_clone/services/firebase_service.dart';

class RootController extends GetxController {
  final splash = true.obs;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void onInit() {
    super.onInit();
    //Initialize Frebase & Login check
    FirebaseService.to.initFirebase();
    //Splash screen
    Future.delayed(const Duration(seconds: 3), () {
      splash.value = false;
    });
  }

  //Drawer open
  void openDrawer() {
    scaffoldKey.currentState!.openDrawer();
  }
}
