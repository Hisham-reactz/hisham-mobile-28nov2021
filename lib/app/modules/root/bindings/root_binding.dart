import 'package:get/get.dart';
import 'package:twitter_clone/app/modules/root/controllers/root_controller.dart';

class RootBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RootController>(
      () => RootController(),
    );
  }
}
