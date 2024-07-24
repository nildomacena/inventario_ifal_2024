import 'package:get/get.dart';
import 'package:inventario_ifal/data/repositories/auth_repository.dart';
import 'package:inventario_ifal/modules/login/login_controller.dart';

class LoginBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(() => LoginController(
        authRepository: AuthRepository(authProvider: Get.find())));
  }
}
