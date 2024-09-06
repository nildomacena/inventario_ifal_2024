import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventario_ifal/data/models/localidade.dart';
import 'package:inventario_ifal/data/models/panoramica.dart';
import 'package:inventario_ifal/data/repositories/localidade_repository.dart';
import 'package:inventario_ifal/shared/utils.dart';

class PanoramicasController extends GetxController {
  late Localidade localidade;
  final LocalidadeRepository repository;
  File? imagem;
  List<File> imagens = [];
  List<Panoramica> panoramicas = [];
  bool salvando = false;

  PanoramicasController(this.repository) {
    if (Get.arguments == null || Get.arguments['localidade'] == null) {
      Get.back();
      UtilService.snackBarErro(mensagem: 'Localidade nao encontrada');
    }
    localidade = Get.arguments['localidade'];
    getPanoramicas();
  }

  getPanoramicas() async {
    try {
      panoramicas = await repository.getPanoramicas(localidade.inventarioId);
      update();
    } catch (e) {
      print('erro ao buscar imagens panoramicas');
    }
  }

  getImage() async {
    try {
      imagem = await UtilService.getImage();
      if (imagem != null) imagens.add(imagem!);
      update();
    } catch (e) {
      print('erro ao buscar imagem');
    }
  }

  excluirNovaPanoramica(File panoramica) {
    imagens.remove(panoramica);
    update();
  }

  excluirPanoramica(Panoramica panoramica) async {
    bool? result = await Get.dialog(AlertDialog(
      title: const Text('Confirmação'),
      content: const Text(
          'Deseja realmente excluir essa imagem?\nEssa ação é irreversível.'),
      actions: [
        TextButton(
          onPressed: () {
            Get.back();
          },
          child: const Text('CANCELAR'),
        ),
        TextButton(
          onPressed: () {
            Get.back(result: true);
          },
          child: const Text('EXCLUIR'),
        ),
      ],
    ));
    if (result == null) return;

    localidade = await repository.excluirPanoramica(panoramica);
    update();
  }

  saveImage() async {
    if (imagem == null || imagens.isEmpty) {
      UtilService.snackBarErro(mensagem: 'Selecione uma imagem para ser salva');
    }
    salvando = true;
    update();
    try {
      await repository.salvarPanoramicas(
          imagens: imagens, localidade: localidade);
      imagens = [];
      update();
      Get.back();
      UtilService.snackBar(
          titulo: 'Imagens salvas',
          mensagem: 'As imagens panoramicas foram salvas');
    } catch (e) {
      print(e);
      UtilService.snackBarErro(mensagem: 'Erro ao salvar imagem $e');
    } finally {
      salvando = false;
      update();
    }
  }
}
