import 'package:get/get.dart';
import 'package:inventario_ifal/data/repositories/auth_repository.dart';
import 'package:inventario_ifal/data/repositories/localidade_repository.dart';
import 'package:inventario_ifal/modules/finalizar_localidade/finalizar_localidade_controller.dart';

class FinalizarLocalidadeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FinalizarLocalidadeController>(() =>
        FinalizarLocalidadeController(
            LocalidadeRepository(), AuthRepository(authProvider: Get.find())));
  }
}
