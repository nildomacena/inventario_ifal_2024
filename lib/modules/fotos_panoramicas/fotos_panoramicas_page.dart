import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventario_ifal/modules/fotos_panoramicas/fotos_panoramicas_controller.dart';
import 'package:inventario_ifal/modules/fotos_panoramicas/widgets/view_image.dart';

class PanoramicasPage extends StatelessWidget {
  final PanoramicasController controller = Get.find();

  PanoramicasPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: controller.getImage,
          child: const Icon(Icons.add_a_photo_outlined),
        ),
        appBar: AppBar(title: const Text('Fotos Panorâmicas')),
        body: GetBuilder<PanoramicasController>(
          builder: (_) {
            return SizedBox(
              width: Get.width,
              child: ListView(
                shrinkWrap: true,
                children: [
                  if (controller.panoramicas.isEmpty &&
                      controller.imagens.isEmpty) ...{
                    Container(
                        alignment: Alignment.center,
                        margin: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 10),
                        child: const Text('Sem imagens adicionadas',
                            style: TextStyle(fontSize: 20))),
                  } else ...{
                    if (_.panoramicas.isNotEmpty) ...{
                      Container(
                          alignment: Alignment.center,
                          margin: const EdgeInsets.symmetric(
                              vertical: 20, horizontal: 10),
                          child: const Text('Imagens Salvas',
                              style: TextStyle(fontSize: 20))),
                      GridView.builder(
                        itemCount: _.panoramicas.length,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                mainAxisSpacing: 5,
                                crossAxisSpacing: 10,
                                crossAxisCount: 2),
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Get.to(() =>
                                  ViewImage(controller.panoramicas[index]));
                            },
                            child: Stack(
                              fit: StackFit.expand,
                              children: [
                                Image.network(
                                  controller.panoramicas[index].url,
                                  fit: BoxFit.cover,
                                ),
                                Positioned(
                                    top: 2,
                                    right: 2,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(40),
                                        color: Colors.white,
                                      ),
                                      child: IconButton(
                                          onPressed: () {
                                            controller.excluirPanoramica(
                                                controller.panoramicas[index]);
                                          },
                                          style: IconButton.styleFrom(
                                              backgroundColor: Colors.white),
                                          icon: const Icon(Icons.delete)),
                                    ))
                              ],
                            ),
                          );
                        },
                      ),
                    },
                    const Divider(),
                    if (controller.imagens.isNotEmpty) ...{
                      Container(
                          alignment: Alignment.center,
                          margin: const EdgeInsets.symmetric(
                              vertical: 20, horizontal: 10),
                          child: const Text('Novas Imagens',
                              style: TextStyle(fontSize: 20))),
                      GridView.builder(
                        padding: const EdgeInsets.only(bottom: 30),
                        itemCount: controller.imagens.length,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                mainAxisSpacing: 5,
                                crossAxisSpacing: 10,
                                crossAxisCount: 2),
                        itemBuilder: (context, index) {
                          return Container(
                            child: Stack(
                              fit: StackFit.expand,
                              children: [
                                Image.file(
                                  controller.imagens[index],
                                  fit: BoxFit.cover,
                                ),
                                Positioned(
                                    top: 2,
                                    right: 2,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(40),
                                        color: Colors.white,
                                      ),
                                      child: IconButton(
                                          onPressed: () {
                                            controller.excluirNovaPanoramica(
                                              controller.imagens[index],
                                            );
                                          },
                                          style: IconButton.styleFrom(
                                              backgroundColor: Colors.white),
                                          icon: Icon(Icons.delete)),
                                    ))
                              ],
                            ),
                          );
                        },
                      ),
                    },
                  },

                  /* Container(
                      margin: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 10),
                      child: const Text('Novas imagens',
                          style: TextStyle(fontSize: 20))),
                  GetBuilder<PanoramicasController>(builder: (_) {
                    if (_.imagem != null) {
                      return SizedBox(
                        width: Get.width,
                        height: 400,
                        child: Image.file(_.imagem!),
                      );
                    } else if (_.localidade.panoramica.isNotEmpty) {
                      return SizedBox(
                        width: Get.width,
                        height: 400,
                        child: Image.network(_.localidade.panoramica),
                      );
                    }
                    return Container();
                  }), */
                  if (_.imagens.isNotEmpty)
                    Container(
                      margin: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 30),
                      height: 50,
                      child: ElevatedButton.icon(
                          onPressed: _.imagem == null || _.salvando
                              ? null
                              : _.saveImage,
                          icon: const Icon(Icons.save),
                          label: Text(
                            _.salvando
                                ? 'Salvando...'
                                : _.panoramicas.isNotEmpty && _.imagem != null
                                    ? 'Atualizar panorâmica'
                                    : _.imagem != null
                                        ? _.imagens.length > 1
                                            ? 'Salvar imagens'
                                            : 'Salvar Imagem'
                                        : 'Selecione uma imagem',
                            style: const TextStyle(fontSize: 15),
                          )),
                    )
                ],
              ),
            );
          },
        ));
  }
}
