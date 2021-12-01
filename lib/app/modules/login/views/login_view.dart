import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:twitter_clone/app/modules/login/controllers/login_controller.dart';
import 'package:twitter_clone/services/utility_service.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final util = UtilityService.to;
    double height(double px) => util.height(context, px);
    double width(double px) => util.width(context, px);
    return loginForm(height, width, context);
  }

  Form loginForm(double Function(double px) height,
      double Function(double px) width, BuildContext context) {
    return Form(
        key: controller.formKey, child: formItems(height, width, context));
  }

  Column formItems(double Function(double px) height,
      double Function(double px) width, BuildContext context) {
    var buttonStyle = ButtonStyle(
        fixedSize: MaterialStateProperty.all(Size(width(100), 25)),
        backgroundColor: MaterialStateProperty.all(Colors.lightBlue),
        shape: MaterialStateProperty.all(const StadiumBorder()));
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
            padding: EdgeInsets.only(
                top: height(100), left: width(30), bottom: height(30)),
            child: const Text(
              'Log in to Twitter',
              style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
            )),
        Padding(
            padding: EdgeInsets.only(left: width(30), right: width(30)),
            child: TextFormField(
              key: const ValueKey('emailInput'),
              validator: (val) => controller.validate(val, 'Email'),
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(labelText: 'Email'),
            )),
        Padding(
            padding: EdgeInsets.only(
                top: height(20), left: width(30), right: width(30)),
            child: TextFormField(
              key: const ValueKey('passwordInput'),
              validator: (val) => controller.validate(val, 'Password'),
              keyboardType: TextInputType.visiblePassword,
              obscureText: true,
              decoration: const InputDecoration(labelText: 'Password'),
            )),
        Padding(
            padding: EdgeInsets.only(top: height(20), right: width(30)),
            child: Align(
              child: ElevatedButton(
                  key: const ValueKey('loginButton'),
                  style: buttonStyle,
                  onPressed: () async => controller.submitForm(context),
                  child: Obx(() => Visibility(
                      visible: !controller.loading.value,
                      child: const Text(
                        'Log In',
                        style: TextStyle(color: Colors.white),
                      ),
                      replacement: const SizedBox(
                        height: 25,
                        width: 25,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      )))),
              alignment: Alignment.centerRight,
            ))
      ],
    );
  }
}
