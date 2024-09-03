import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventario_ifal/data/models/bem.dart';
import 'package:inventario_ifal/data/models/localidade.dart';
import 'package:inventario_ifal/data/repositories/bem_repository.dart';
import 'package:inventario_ifal/shared/utils.dart';

class BemController extends GetxController {
  final BemRepository repository;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late Localidade localidade;

  File? image;

  bool particular = false;
  bool semEtiqueta = false;
  bool desfazimento = false;
  bool salvando = false;
  bool alterar =
      false; //Variável que verifica se a tela é para alterar algum bem já existente ou cadastrar um novo
  String radioEstado = '';

  TextEditingController patrimonioController = TextEditingController();
  TextEditingController descricaoController = TextEditingController();
  TextEditingController numeroSerieController = TextEditingController();
  TextEditingController observacoesController = TextEditingController();

  FocusNode patrimonioFocus = FocusNode();
  FocusNode descricaoFocus = FocusNode();
  FocusNode numeroSerieFocus = FocusNode();
  FocusNode observacoesFocus = FocusNode();

  Bem? bem;

  BemController(this.repository) {
    if (Get.arguments != null) {
      if (Get.arguments['bem'] != null) {
        bem = Get.arguments['bem'];
        patchFormBem();
      }
      if (Get.arguments['localidade'] == null) {
        Get.back();
        UtilService.snackBarErro(mensagem: 'Localidade não encontrada');
      }
      localidade = Get.arguments['localidade'];
    } else {
      Get.back();
      UtilService.snackBarErro(mensagem: 'Localidade não encontrada');
    }
  }

  patchFormBem() {
    if (bem == null) return;
    patrimonioController.text = bem!.patrimonio ?? '';
    descricaoController.text = bem!.descricao;
    numeroSerieController.text = bem!.numeroSerie ?? '';
    observacoesController.text = bem!.observacoes ?? '';
    radioEstado = bem!.estadoBem;
    particular = bem!.bemParticular;
    semEtiqueta = bem!.semEtiqueta;
    desfazimento = bem!.indicaDesfazimento;
  }

  onPatrimonioSubmit(String? string) {
    patrimonioFocus.unfocus();
    descricaoFocus.requestFocus();
    onPatrimonioComplete();
  }

  onPatrimonioComplete() {
    print('onPatrimonioComplete');
    descricaoController.text =
        utilService.buscarDescricao(patrimonioController.text) ?? '';

    /*  descricaoController.text =
        utilService.getDescricaoPorTombamento(patrimonioController.text); */
    /* Localidade localidade = await fireService
                      .verificaBemJaCadastrado(patrimonioController.text);
                  if (localidade != null) {
                    Get.dialog(AlertDialog(
                      title: const Text('Bem Já inventariado'),
                      content: Text(
                          'O bem ${descricaoController.text ?? ''} já foi inventariado na localidade ${localidade.nome}'),
                      actions: [
                        FlatButton(
                          child: const Text('OK'),
                          onPressed: () {
                            Get.back();
                          },
                        )
                      ],
                    ));
                  } */
  }

  String? validatorPatrimonio(String? patrimonio) {
    if ((patrimonio == null || patrimonio.isEmpty) &&
        (!semEtiqueta && !particular)) {
      // salvando = false;
      // update();
      return "Digite o patrimônio do bem";
    }
    return null;
  }

  onChangeRadioButton(String? value) {
    radioEstado = value ?? '';
    update();
  }

  onChangeBemParticular([bool? value]) {
    particular = value ?? !particular;
    if (particular) {
      patrimonioController.text = '';
    }
    update();
  }

  onChangeDesfazimento([bool? value]) {
    desfazimento = value ?? !particular;
    update();
  }

  getImage() async {
    try {
      image = await UtilService.getImage();
      update();
    } catch (e) {
      print('Erro ao buscar imagem: $e');
    }
  }

  clearImage() async {
    bool? excluir = await Get.dialog(AlertDialog(
      title: const Text('Confirmação'),
      content: const Text('Deseja realmente excluir a imagem?'),
      actions: [
        TextButton(
          child: const Text('Cancelar'),
          onPressed: () {
            Get.back();
          },
        ),
        TextButton(
          child: const Text('Excluir'),
          onPressed: () {
            Get.back(result: true);
          },
        ),
      ],
    ));
    if (excluir == null || !excluir) return;
    image = null;
    update();
  }

  toggleSemEtiqueta([bool? value]) {
    semEtiqueta = value ?? !semEtiqueta;
    update();
  }

  scanQrCode() async {
    if (kDebugMode) {
      patrimonioController.text = '152025';
      onPatrimonioComplete();
      return;
    }
    try {
      String qrCode = await UtilService.scanQrCode();
      patrimonioController.text = qrCode;
      onPatrimonioComplete();
      update();
      print('qrCode: $qrCode');
    } catch (e) {
      UtilService.snackBarErro(mensagem: 'Erro ao scanear');
    }
  }

  onSubmitForm() {
    if (!formKey.currentState!.validate()) {
      return;
    }
    if (radioEstado.isEmpty) {
      UtilService.snackBarErro(mensagem: 'Selecione o estado do bem');
      return;
    }
    bem != null ? alterarBem() : cadastrarBem();
  }

  cadastrarBem() async {
    if (image == null) {
      UtilService.snackBarErro(mensagem: 'Selecione uma imagem');
      return;
    }
    try {
      print('object');
      salvando = true;
      update();
      await repository.createBem(
          image: image!,
          localidadeId: localidade.localidadeId,
          inventarioLocalidadeId: localidade.inventarioId,
          patrimonio: patrimonioController.text,
          descricao: descricaoController.text,
          numeroSerie: numeroSerieController.text,
          estadoBem: radioEstado,
          observacoes: observacoesController.text,
          bemParticular: particular,
          semEtiqueta: semEtiqueta,
          indicaDesfazimento: desfazimento);
      UtilService.snackBar(
          titulo: 'Sucesso!',
          mensagem: 'Cadastro de bem realizado com sucesso');
      resetForm();
    } catch (e) {
      print('Erro ao salvar bem: $e');
      UtilService.snackBarErro(
          titulo: 'Erro ao cadastrar bem', mensagem: e.toString());
    } finally {
      salvando = false;
      update();
    }
  }

  alterarBem() async {
    if (bem == null) {
      return;
    }

    try {
      salvando = true;
      update();
      await repository.updateBem(
          id: bem!.id,
          image: image,
          localidadeId: localidade.localidadeId,
          patrimonio: patrimonioController.text,
          descricao: descricaoController.text,
          numeroSerie: numeroSerieController.text,
          estadoBem: radioEstado,
          observacoes: observacoesController.text,
          bemParticular: particular,
          semEtiqueta: semEtiqueta,
          indicaDesfazimento: desfazimento);
      Get.back();
      UtilService.snackBar(
          titulo: 'Sucesso!',
          mensagem: 'Cadastro de bem realizado com sucesso');
      resetForm();
    } catch (e) {
      print('Erro ao salvar bem: $e');
      UtilService.snackBarErro(
          titulo: 'Erro ao cadastrar bem', mensagem: e.toString());
    } finally {
      salvando = false;
      update();
    }
  }

  resetForm() {
    image = null;
    patrimonioController.text = '';
    descricaoController.text = '';
    numeroSerieController.text = '';
    observacoesController.text = '';
    radioEstado = '';
    particular = false;
    semEtiqueta = false;
    desfazimento = false;
    bem = null;
    update();
  }

  excluirBem() async {
    if (bem == null) return;
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

    try {
      await repository.excluirBem(bem!.id);
      Get.back();
      UtilService.snackBar(titulo: 'Bem excluído com sucesso', mensagem: '');
    } catch (e) {
      print(e);
      UtilService.snackBarErro(
          mensagem:
              'Erro ao excluir bem. Verifique se o mesmo foi excluído e tente novamente');
    }
  }
}
