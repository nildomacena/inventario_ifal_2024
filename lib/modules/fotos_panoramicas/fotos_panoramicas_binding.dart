import 'package:get/get.dart';
import 'package:inventario_ifal/data/repositories/bem_repository.dart';
import 'package:inventario_ifal/data/repositories/localidade_repository.dart';
import 'package:inventario_ifal/modules/fotos_panoramicas/fotos_panoramicas_controller.dart';

class PanoramicasBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PanoramicasController>(
        () => PanoramicasController(LocalidadeRepository()));
  }
}
