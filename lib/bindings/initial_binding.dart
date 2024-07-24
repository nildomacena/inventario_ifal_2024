import 'package:get/get.dart';
import 'package:inventario_ifal/data/providers/auth_provider.dart';

class InitialBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<AuthProvider>(AuthProvider(), permanent: true);
  }
}
