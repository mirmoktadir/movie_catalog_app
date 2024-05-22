import 'package:get/get.dart';

import '../../modules/home/views/home_view.dart';

class NavbarController extends GetxController {
  List navigation = [
    const HomeView(),
  ];
  RxInt selectedIndex = 0.obs;

  void onTap(int index) {
    selectedIndex.value = index;
  }
}
