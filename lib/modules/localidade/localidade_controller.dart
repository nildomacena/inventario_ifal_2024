import 'package:get/get.dart';
import 'package:inventario_ifal/data/models/localidade.dart';
import 'package:inventario_ifal/data/repositories/auth_repository.dart';
import 'package:inventario_ifal/data/repositories/localidade_repository.dart';
import 'package:inventario_ifal/routes/app_routes.dart';

class LocalidadeController extends GetxController {
  late Localidade localidade;

  LocalidadeRepository localidadeRepository;
  AuthRepository authRepository;

  LocalidadeController({
    required this.localidadeRepository,
    required this.authRepository,
  }) {
    localidade = Get.arguments as Localidade;
  }

  buscaDetalhesLocalidade() async {
    // localidadeRepository.buscaDetalhesLocalidade(localidade.id);
    update();
  }

  onAdicionarBem() {
    Get.toNamed(Routes.bem, arguments: {'localidade': localidade});
  }

  void signOut() {
    authRepository.signOut();
    Get.offAllNamed(Routes.login);
  }

  @override
  void onInit() {
    buscaDetalhesLocalidade();
    super.onInit();
  }
}
