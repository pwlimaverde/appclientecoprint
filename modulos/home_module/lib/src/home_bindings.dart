import 'package:dependency_module/dependency_module.dart';
import 'home_controller.dart';

class HomeBiding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() {
      return HomeController();
    });
  }
}
