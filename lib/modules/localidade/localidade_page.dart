import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventario_ifal/modules/localidade/localidade_controller.dart';
import 'package:inventario_ifal/routes/app_routes.dart';

class LocalidadePage extends StatelessWidget {
  final LocalidadeController controller = Get.find();
  LocalidadePage({super.key});

  Widget buildCardInfo() {
    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.all(8.0),
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: 2),
            child: Text(
              'Nome: ${controller.localidade.nome}',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 2),
            child: Text(
              'Número de bens: ${controller.localidade.numeroBens ?? 'Carregando...'}',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          //status
          Container(
            margin: EdgeInsets.symmetric(vertical: 2),
            child: Text(
              'Status: ${controller.localidade.statusFormatado}',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Divider(),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              OutlinedButton(
                onPressed: () {},
                child: const Text('Fotos Panorâmicas'),
              ),
              SizedBox(
                width: 10,
              ),
              OutlinedButton(
                onPressed: () {},
                child: const Text('Finalizar Localidade'),
              ),
            ],
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: controller.onAdicionarBem,
        label: const Text('Cadastrar Bem'),
        icon: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Text(controller.localidade.nome),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              controller.signOut();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            buildCardInfo(),
          ],
        ),
      ),
    );
  }
}
