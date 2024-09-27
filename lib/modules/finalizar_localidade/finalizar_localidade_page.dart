import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventario_ifal/modules/finalizar_localidade/finalizar_localidade_controller.dart';

class FinalizarLocalidadePage extends StatelessWidget {
  final FinalizarLocalidadeController controller = Get.find();
  FinalizarLocalidadePage({super.key});

  final TextStyle style =
      const TextStyle(fontFamily: 'Montserrat', fontSize: 19);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(controller.localidade.nome),
      ),
      body: Container(
        padding: const EdgeInsets.only(top: 10, bottom: 10),
        child: GetBuilder<FinalizarLocalidadeController>(builder: (_) {
          print('localidadadse relatório: ${_.localidade}');

          return Column(
            children: <Widget>[
              Expanded(
                  child: Container(
                      height: 80,
                      color: controller.imagem != null &&
                              controller.localidade.relatorio == null
                          ? Colors.grey
                          : Colors.white,
                      alignment: Alignment.center,
                      child: controller.imagem != null
                          ? Image.file(
                              controller.imagem!,
                              fit: BoxFit.cover,
                            )
                          : controller.localidade.relatorio != null
                              ? Image.network(
                                  controller.localidade.relatorio!,
                                  fit: BoxFit.cover,
                                )
                              : const Icon(Icons.photo))),
              ElevatedButton(
                  onPressed: controller.getImage,
                  child: Text(controller.localidade.relatorio != null
                      ? 'ALTERAR FOTO DO RELATÓRIO'
                      : controller.imagem == null
                          ? 'ADICIONAR FOTO DO RELATÓRIO'
                          : 'ALTERAR FOTO')),
              const Divider(),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.only(left: 5, right: 5),
                  child: TextField(
                    maxLines: 8,
                    textCapitalization: TextCapitalization.sentences,
                    controller: controller.textEditingController,
                    decoration: const InputDecoration(hintText: 'Observações'),
                    style: style,
                  ),
                ),
              ),
              if (controller.localidade.status == 'finalizada')
                Container(
                    height: 60,
                    alignment: Alignment.center,
                    child: Container(
                      /* height: 50,
                      width: 200, */
                      child: const ElevatedButton(
                        onPressed: null,
                        child: Text(
                          'LOCALIDADE FINALIZADA',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w500),
                        ),
                      ),
                    )),
              if (controller.localidade.status != 'finalizada')
                Container(
                    height: 60,
                    alignment: Alignment.center,
                    child: Container(
                      child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: WidgetStateProperty.all<Color>(
                                controller.imagem == null || controller.salvando
                                    ? Colors.grey
                                    : Colors.blue)),
                        onPressed:
                            controller.imagem == null || controller.salvando
                                ? null
                                : controller.salvar,
                        child: Text(
                          controller.salvando
                              ? 'SALVANDO...'
                              : 'FINALIZAR LOCALIDADE',
                          style: const TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ))
            ],
          );
        }),
      ),
    );
  }
}
