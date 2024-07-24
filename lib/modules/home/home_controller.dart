import 'package:get/get.dart';
import 'package:inventario_ifal/data/repositories/auth_repository.dart';
import 'package:inventario_ifal/routes/app_routes.dart';

class HomeController extends GetxController {
  AuthRepository authRepository;
  HomeController({required this.authRepository});

  void signOut() {
    authRepository.signOut();
    Get.offAllNamed(Routes.login);
  }
}
