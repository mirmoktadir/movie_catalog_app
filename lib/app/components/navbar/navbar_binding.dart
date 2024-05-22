import 'package:get/get.dart';

import '../../modules/home/controllers/home_controller.dart';
import 'navbar_controller.dart';

class NavbarBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );

    Get.lazyPut<NavbarController>(
      () => NavbarController(),
    );
  }
}
