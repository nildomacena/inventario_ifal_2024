import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:get/get.dart';
import 'package:inventario_ifal/modules/bem/bem_controller.dart';

class BemPage extends StatelessWidget {
  final BemController controller = Get.find();
  final TextStyle style =
      const TextStyle(fontFamily: 'Montserrat', fontSize: 19);
  BemPage({super.key});

  Widget row(File? image) {
    return Container(
      alignment: Alignment.center,
      color: Colors.grey,
      width: Get.width,
      height: 170,
      child: image != null
          ? GestureDetector(
              onTap: () {},
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.file(
                    image,
                  ),
                  Positioned(
                      bottom: 10,
                      left: Get.width / 2 + 20,
                      child: IconButton(
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                        onPressed: controller.clearImage,
                      )),
                  Positioned(
                      bottom: 10,
                      right: Get.width / 2 + 20,
                      child: IconButton(
                        icon: const Icon(Icons.remove_red_eye),
                        onPressed: () {},
                      )),
                ],
              ),
            )
          : controller.bem != null
              ? GestureDetector(
                  onTap: () {},
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.network(
                        controller.bem!.imagem,
                        loadingBuilder: (BuildContext context, Widget child,
                            ImageChunkEvent? loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Center(
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                      loadingProgress.expectedTotalBytes!
                                  : null,
                            ),
                          );
                        },
                      ),
                      Positioned(
                          bottom: 10,
                          left: Get.width / 2 + 20,
                          child: IconButton(
                            icon: const Icon(
                              Icons.cameraswitch_outlined,
                              color: Colors.red,
                            ),
                            onPressed: controller.getImage,
                          )),
                      Positioned(
                          bottom: 10,
                          right: Get.width / 2 + 20,
                          child: IconButton(
                            icon: const Icon(Icons.remove_red_eye),
                            onPressed: () {},
                          )),
                    ],
                  ),
                )
              : GestureDetector(
                  onTap: () {
                    controller.getImage();
                  },
                  child: Container(
                    child: const Text(
                      'Selecionar Foto',
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                    ),
                  )),
    );
  }

  @override
  Widget build(BuildContext context) {
    patrimonioField() {
      return SizedBox(
        height: 60,
        width: double.infinity,
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 7,
              child: TextFormField(
                  enabled: !controller.semEtiqueta,
                  obscureText: false,
                  style: style,
                  readOnly: controller.particular,
                  textCapitalization: TextCapitalization.sentences,
                  keyboardType: TextInputType.number,
                  controller: controller.patrimonioController,
                  focusNode: controller.patrimonioFocus,
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: controller.onPatrimonioSubmit,
                  onEditingComplete: controller.onPatrimonioComplete,
                  validator: controller.validatorPatrimonio,
                  decoration: InputDecoration(
                      contentPadding:
                          const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                      hintText: controller.particular
                          ? 'Bem particular'
                          : "Patrimônio do bem",
                      hintStyle: TextStyle(
                          color: Colors.grey[400], fontWeight: FontWeight.w400),
                      border: const UnderlineInputBorder())),
            ),
            IconButton(
                icon: const Icon(FontAwesome.qrcode),
                onPressed:
                    controller.semEtiqueta ? null : controller.scanQrCode),
            Expanded(
              flex: 5,
              child: Row(
                children: <Widget>[
                  Checkbox(
                      value: controller.semEtiqueta,
                      onChanged: controller.particular
                          ? null
                          : controller.toggleSemEtiqueta),
                  Expanded(
                    flex: 2,
                    child: GestureDetector(
                      onTap: controller.particular
                          ? null
                          : controller.toggleSemEtiqueta,
                      child: const AutoSizeText(
                        'Sem Etiqueta?',
                        maxLines: 1,
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      );
    }

    Widget containerEstado() => SizedBox(
          height: 80,
          width: double.infinity,
          child: Stack(
            fit: StackFit.expand,
            children: [
              Container(
                margin: const EdgeInsets.fromLTRB(5, 15, 5, 0),
                padding: const EdgeInsets.only(right: 10),
                decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Radio(
                      value: 'uso',
                      groupValue: controller.radioEstado,
                      onChanged: controller.onChangeRadioButton,
                    ),
                    GestureDetector(
                      child: const Text(
                        'Em uso',
                        style: TextStyle(fontSize: 14),
                      ),
                      onTap: () {
                        print('onTap - uso');
                        controller.onChangeRadioButton('uso');
                      },
                    ),
                    Expanded(
                      child: Container(),
                    ),
                    Radio(
                      value: 'ocioso',
                      groupValue: controller.radioEstado,
                      onChanged: controller.onChangeRadioButton,
                    ),
                    GestureDetector(
                      child: const Text(
                        'Ocioso',
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                      onTap: () {
                        print('onTap - ocioso');
                        controller.onChangeRadioButton('ocioso');
                      },
                    ),
                    Expanded(
                      child: Container(),
                    ),
                    Radio(
                      value: 'danificado',
                      groupValue: controller.radioEstado,
                      onChanged: controller.onChangeRadioButton,
                    ),
                    GestureDetector(
                      child: const AutoSizeText(
                        'Danificado',
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                      onTap: () {
                        print('onTap - danificado');
                        controller.onChangeRadioButton('danificado');
                      },
                    ),
                  ],
                ),
              ),
              Positioned(
                  top: 5,
                  left: 20,
                  child: Center(
                      child: Container(
                          color: Colors.white,
                          child: const Text(
                            'Estado do bem',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w300),
                          ))))
            ],
          ),
        );

    Widget checkBemParticular() => Container(
          decoration: BoxDecoration(border: Border.all(width: .1)),
          height: 60,
          width: MediaQuery.of(context).size.width,
          child: Row(
            children: <Widget>[
              Checkbox(
                  value: controller.particular,
                  onChanged: controller.onChangeBemParticular),
              Expanded(
                flex: 2,
                child: GestureDetector(
                  onTap: controller.onChangeBemParticular,
                  child: const Text(
                    'Bem particular?',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        );

    Widget checkDesfazimento() => Container(
          decoration: BoxDecoration(border: Border.all(width: .1)),
          height: 60,
          width: MediaQuery.of(context).size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Checkbox(
                  value: controller.desfazimento,
                  onChanged: controller.onChangeDesfazimento),
              GestureDetector(
                onTap: controller.onChangeDesfazimento,
                child: const Text(
                  'Indica bem para desfazimento?',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
                ),
              )
            ],
          ),
        );
    Widget observacoesField() => TextFormField(
        obscureText: false,
        style: style,
        textCapitalization: TextCapitalization.sentences,
        keyboardType: TextInputType.text,
        controller: controller.observacoesController,
        focusNode: controller.observacoesFocus,
        maxLines: 2,
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            hintText: "Observações",
            hintStyle:
                TextStyle(color: Colors.grey[400], fontWeight: FontWeight.w400),
            border: const UnderlineInputBorder()));

    descricaoField() {
      return SizedBox(
        height: 60,
        width: double.infinity,
        child: TextFormField(
            obscureText: false,
            style: style,
            textCapitalization: TextCapitalization.sentences,
            keyboardType: TextInputType.text,
            controller: controller.descricaoController,
            focusNode: controller.descricaoFocus,
            textInputAction: TextInputAction.next,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Campo obrigatório';
              }
              return null;
            },
            decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                hintText: "Descrição do Bem",
                hintStyle: TextStyle(
                    color: Colors.grey[400], fontWeight: FontWeight.w400),
                border: const UnderlineInputBorder())),
      );
    }

    Widget salvarButton() => Container(
        //alignment: Alignment.center,
        margin: const EdgeInsets.only(top: 20),
        width: MediaQuery.of(context).size.width,
        height: 50,
        child: ElevatedButton(
            onPressed: controller.salvando ? null : controller.onSubmitForm,
            child: Text(
              controller.salvando ? 'Salvando dados...' : 'Salvar',
              style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.white),
            )));
    return Scaffold(
      appBar: AppBar(
        title: const Text('Adicionar Bem'),
        actions: [
          if (controller.bem != null)
            IconButton(
                onPressed: controller.excluirBem, icon: Icon(Icons.delete))
        ],
      ),
      body: SingleChildScrollView(
        child: Form(
          key: controller.formKey,
          child: GetBuilder<BemController>(
            builder: (_) {
              return Column(
                children: [
                  row(controller.image),
                  patrimonioField(),
                  descricaoField(),
                  containerEstado(),
                  checkBemParticular(),
                  checkDesfazimento(),
                  observacoesField(),
                  salvarButton()
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
