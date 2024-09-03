import 'package:flutter/material.dart';

class ViewImage extends StatelessWidget {
  final dynamic image;
  const ViewImage(this.image, {super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(title: Text('Visualizar Imagem')),
            body: image is String ? Image.network(image) : Image.file(image)));
  }
}
