import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:twitter_clone/services/firebase_service.dart';

class LoginController extends GetxController {
  final formKey = GlobalKey<FormState>();
  String? email;
  String? password;
  final loading = false.obs;

  //Login form submit
  void submitForm(context) async {
    if (formKey.currentState!.validate()) {
      loading.value = true;
      FirebaseService.to.firebaseLogin(email, password);
      Future.delayed(const Duration(seconds: 1), () {
        loading.value = false;
      });
    }
  }

  //Login form validate
  String? validate(String? value, input) {
    if (value == null || value.trim().isEmpty) {
      return 'No Empty $input!';
    } else {
      if (input == 'Email') {
        if (GetUtils.isEmail(value)) {
          email = value;
          return null;
        }
        return 'Invalid $input!';
      }
      if (input == 'Password') {
        if (GetUtils.isLengthGreaterOrEqual(value, 6)) {
          password = value;
          return null;
        }
        return 'Invalid $input!';
      }
      return null;
    }
  }
}
