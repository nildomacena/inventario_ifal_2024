import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:inventario_ifal/data/models/localidade.dart';
import 'package:inventario_ifal/data/repositories/auth_repository.dart';
import 'package:inventario_ifal/data/repositories/localidade_repository.dart';
import 'package:inventario_ifal/routes/app_routes.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HomeController extends GetxController {
  AuthRepository authRepository;
  LocalidadeRepository localidadeRepository;
  final SupabaseClient supabase = Supabase.instance.client;
  TextEditingController searchController = TextEditingController();
  List<Localidade> localidades = [];
  List<Localidade> localidadesFiltradas = [];

  HomeController(
      {required this.authRepository, required this.localidadeRepository});

  void signOut() {
    authRepository.signOut();
    Get.offAllNamed(Routes.login);
  }

  Future<void> getLocalidades() async {
    try {
      final response = await localidadeRepository.getLocalidades();
      localidadesFiltradas = localidades = response;
      update();
    } catch (e) {
      Get.snackbar('Erro', e.toString());
    }
  }

  void filterLocalidades(String query) {
    localidadesFiltradas = localidades
        .where((element) =>
            element.nome.toLowerCase().contains(query.toLowerCase()))
        .toList();
    update();
  }

  @override
  void onInit() {
    getLocalidades();
    super.onInit();
  }
}
