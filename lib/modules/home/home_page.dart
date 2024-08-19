import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:inventario_ifal/modules/home/home_controller.dart';

class HomePage extends StatelessWidget {
  final HomeController controller = Get.find();
  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              controller.signOut();
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await controller.getLocalidades();
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              // filtro de localidades
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                    controller: controller.searchController,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.search),
                      suffixIcon: GestureDetector(
                        onTap: () {
                          controller.searchController.clear();
                          controller.filtraLocalidades('');
                        },
                        child: const Icon(Icons.clear),
                      ),
                      labelText: 'Filtrar localidades',
                      border: const OutlineInputBorder(),
                    ),
                    onChanged: controller.filtraLocalidades),
              ),
              GetBuilder<HomeController>(
                builder: (_) {
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: controller.localidadesFiltradas.length,
                    itemBuilder: (context, index) {
                      //Coloque bordas uma fonte maior e negrita
                      return Container(
                        alignment: Alignment.center,
                        margin: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                            color: Colors.grey,
                            width: 1,
                          ),
                        ),
                        child: ListTile(
                          onTap: () {
                            controller.irParaLocalidade(
                                controller.localidadesFiltradas[index]);
                          },
                          title: Container(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Text(
                              controller.localidadesFiltradas[index].nome,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
