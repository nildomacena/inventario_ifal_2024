import 'package:get/get.dart';
import 'package:inventario_ifal/data/repositories/auth_repository.dart';
import 'package:inventario_ifal/modules/home/home_controller.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController(
        authRepository: AuthRepository(authProvider: Get.find())));
  }
}
