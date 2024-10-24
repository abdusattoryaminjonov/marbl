import 'package:get/get.dart';

import '../../presentation/controllers/home_controller.dart';


class RootBinding implements Bindings {
  @override
  void dependencies() {
    // Get.lazyPut(() => StarterController(), fenix: true);
    Get.lazyPut(() => HomeController(), fenix: true);
    // Get.lazyPut(() => IntranetController(), fenix: true);
  }
}