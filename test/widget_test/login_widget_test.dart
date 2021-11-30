import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:matcher/matcher.dart' as m;
import 'package:twitter_clone/app/modules/login/controllers/login_controller.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setUpAll(() => HttpOverrides.global = null);
  final binding = BindingsBuilder(() {
    Get.lazyPut<LoginController>(() => LoginController());
  });

  test('Test Login Binding', () {
    expect(Get.isPrepared<LoginController>(), false);

    /// test you Binding class with BindingsBuilder
    binding.builder();

    expect(Get.isPrepared<LoginController>(), true);

    Get.reset();
  });

  test('Test Login Controller', () async {
    /// Controller can't be on memory
    expect(() => Get.find<LoginController>(),
        throwsA(const m.TypeMatcher<String>()));

    /// build Binding
    binding.builder();

    /// recover your controller
    final controller = Get.find<LoginController>();

    /// check if onInit was called
    expect(controller.initialized, true);

    /// await time request
    await Future.delayed(const Duration(milliseconds: 100));
  });
}
