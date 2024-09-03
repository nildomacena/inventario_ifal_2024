import 'package:get/get.dart';
import 'package:inventario_ifal/data/models/bem.dart';
import 'package:inventario_ifal/data/models/localidade.dart';
import 'package:inventario_ifal/data/repositories/auth_repository.dart';
import 'package:inventario_ifal/data/repositories/bem_repository.dart';
import 'package:inventario_ifal/data/repositories/localidade_repository.dart';
import 'package:inventario_ifal/routes/app_routes.dart';

class LocalidadeController extends GetxController {
  late Localidade localidade;
  List<Bem> bens = [];
  bool loading = true;

  LocalidadeRepository localidadeRepository;
  BemRepository bemRepository;
  AuthRepository authRepository;

  LocalidadeController({
    required this.localidadeRepository,
    required this.authRepository,
    required this.bemRepository,
  }) {
    localidade = Get.arguments as Localidade;
    getBens();
  }

  getBens() async {
    bens = await bemRepository
        .getBensByLocalidadeInventarioId(localidade.inventarioId);
    loading = false;
    update();
  }

  goToBem(Bem bem) async{
    await Get.toNamed(Routes.bem, arguments: {'bem': bem, 'localidade': localidade});
    getBens();
  }

  buscaDetalhesLocalidade() async {
    localidadeRepository.buscaDetalhesLocalidade(localidade.localidadeId);
    update();
  }

  onAdicionarBem() async {
    await Get.toNamed(Routes.bem, arguments: {'localidade': localidade});
    getBens();
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
