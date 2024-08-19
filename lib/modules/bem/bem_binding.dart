import 'package:get/get.dart';
import 'package:inventario_ifal/data/repositories/bem_repository.dart';
import 'package:inventario_ifal/modules/bem/bem_controller.dart';

class BemBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BemController>(() => BemController(BemRepository()));
  }
}
