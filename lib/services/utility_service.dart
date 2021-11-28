import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sized_context/sized_context.dart';

class UtilityService extends GetxService {
  static UtilityService get to => Get.find();

  //snackbar everywhere
  void snack(message) =>
      Get.snackbar(message, '', snackPosition: SnackPosition.BOTTOM);

  //gskinner sized_context package + xd viewport px to %
  Sizer _sizer(context, px) => Sizer(context, px);
  double height(context, px) => _sizer(context, px).getHeight();
  double width(context, px) => _sizer(context, px).getWidth();
}

class Sizer {
  Sizer(this.context, this.px, {Key? key}) : super();
  BuildContext context;
  double px;
  double widthPx = 414;
  double heightPx = 852;

  getWidth() {
    var widthPct = (px * 100) / widthPx;
    return context.widthPct(widthPct * 0.01);
  }

  getHeight() {
    var heightPct = (px * 100) / heightPx;
    return context.heightPct(heightPct * 0.01);
  }
}
