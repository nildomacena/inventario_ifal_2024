import 'package:get/get.dart';
import 'package:inventario_ifal/data/repositories/auth_repository.dart';
import 'package:inventario_ifal/data/repositories/bem_repository.dart';
import 'package:inventario_ifal/data/repositories/localidade_repository.dart';
import 'package:inventario_ifal/modules/localidade/localidade_controller.dart';

class LocalidadeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LocalidadeController>(() => LocalidadeController(
        localidadeRepository: LocalidadeRepository(),
        authRepository: AuthRepository(
          authProvider: Get.find(),
        ),
        bemRepository: BemRepository()));
  }
}
