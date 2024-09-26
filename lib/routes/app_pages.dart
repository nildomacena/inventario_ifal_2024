import 'package:get/get.dart';
import 'package:inventario_ifal/modules/bem/bem_binding.dart';
import 'package:inventario_ifal/modules/bem/bem_page.dart';
import 'package:inventario_ifal/modules/finalizar_localidade/finalizar_localidade_binding.dart';
import 'package:inventario_ifal/modules/finalizar_localidade/finalizar_localidade_page.dart';
import 'package:inventario_ifal/modules/fotos_panoramicas/fotos_panoramicas_binding.dart';
import 'package:inventario_ifal/modules/fotos_panoramicas/fotos_panoramicas_page.dart';
import 'package:inventario_ifal/modules/home/home_binding.dart';
import 'package:inventario_ifal/modules/home/home_page.dart';
import 'package:inventario_ifal/modules/localidade/localidade_binding.dart';
import 'package:inventario_ifal/modules/localidade/localidade_page.dart';
import 'package:inventario_ifal/modules/login/login_binding.dart';
import 'package:inventario_ifal/modules/login/login_page.dart';
import 'package:inventario_ifal/routes/app_routes.dart';

class AppPages {
  static final List<GetPage> routes = [
    GetPage(
      name: Routes.login,
      page: () => LoginPage(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: Routes.home,
      page: () => HomePage(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: Routes.localidade,
      page: () => LocalidadePage(),
      binding: LocalidadeBinding(),
    ),
    GetPage(
      name: Routes.bem,
      page: () => BemPage(),
      binding: BemBinding(),
    ),
    GetPage(
      name: Routes.panoramicas,
      page: () => PanoramicasPage(),
      binding: PanoramicasBinding(),
    ),
    GetPage(
      name: Routes.finalizarLocalidade,
      page: () => FinalizarLocalidadePage(),
      binding: FinalizarLocalidadeBinding(),
    ),
  ];
}
