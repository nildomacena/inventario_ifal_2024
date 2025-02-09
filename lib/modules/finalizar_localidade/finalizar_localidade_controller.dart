import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:inventario_ifal/data/models/localidade.dart';
import 'package:inventario_ifal/data/models/usuario.dart';
import 'package:inventario_ifal/data/repositories/auth_repository.dart';
import 'package:inventario_ifal/data/repositories/localidade_repository.dart';

class FinalizarLocalidadeController extends GetxController {
  final LocalidadeRepository repository;
  final AuthRepository authRepository;
  final picker = ImagePicker();
  TextEditingController textEditingController = TextEditingController();
  late Localidade localidade;
  File? imagem;
  bool salvando = false;

  FinalizarLocalidadeController(this.repository, this.authRepository);

  getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      imagem = File(pickedFile.path);
      update();
    }
  }

  salvar() async {
    if (salvando) return;
    salvando = true;
    update();

    try {
      Usuario? usuario = authRepository.usuario;
      if (usuario == null) {
        Get.snackbar('Erro', 'Usuário não encontrado');
        return;
      }

      if (imagem == null) {
        Get.snackbar('Erro', 'Imagem não encontrada');
        return;
      }

      await repository.finalizarLocalidade(
        localidadeId: localidade.localidadeId,
        imagem: imagem!,
        observacao: textEditingController.text,
        usuarioId: usuario.id,
      );

      Get.back();
      Get.snackbar('Sucesso', 'Relatório salvo com sucesso');
    } catch (e) {
      Get.snackbar('Erro', 'Erro ao salvar relatório');
    } finally {
      salvando = false;
      update();
    }
  }

  @override
  void onInit() {
    if (kDebugMode) textEditingController.text = 'teste teste teste';
    localidade = Get.arguments['localidade'] as Localidade;
    super.onInit();
  }
}
