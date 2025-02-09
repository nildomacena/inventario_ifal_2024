import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:inventario_ifal/data/models/bem.dart';
import 'package:inventario_ifal/data/models/descricao_bem.dart';
import 'package:inventario_ifal/data/models/usuario.dart';
import 'package:inventario_ifal/data/providers/auth_provider.dart';
import 'package:inventario_ifal/shared/exceptions/bem_ja_cadastrado_exception.dart';
import 'package:inventario_ifal/shared/utils.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class BemRepository {
  SupabaseClient client = Supabase.instance.client;
  AuthProvider authProvider = Get.find();

  Future<List<Bem>> getBensByLocalidadeInventarioId(int localidadeId) async {
    final response =
        await client.from('bens').select().eq('inventario_id', localidadeId);
    if (response.isEmpty) {
      return <Bem>[];
    }
    return response.map((e) => Bem.fromMap(e)).toList();
  }

  Future<void> createBem({
    required File image,
    required int localidadeId,
    required int inventarioLocalidadeId,
    required String patrimonio,
    required String numeroSerie,
    required String descricao,
    required String estadoBem,
    required bool bemParticular,
    required bool indicaDesfazimento,
    required String observacoes,
    required bool semEtiqueta,
  }) async {
    String anoInventario = dotenv.env['ANO_INVENTARIO'] ?? '2024';

    String path = patrimonio.isNotEmpty
        ? '$patrimonio/${DateTime.now().microsecondsSinceEpoch}-${UtilService.getFileName(image.path)}'
        : '${DateTime.now().microsecondsSinceEpoch}-${UtilService.getFileName(image.path)}';

    await client.storage.from('inventario').upload(path, image,
        fileOptions: const FileOptions(
          cacheControl: '3600',
          upsert: true,
        ));
    String url = client.storage.from('inventario').getPublicUrl(path);
    Usuario? usuario = authProvider.usuario;
    if (usuario == null) {
      UtilService.snackBarErro(mensagem: 'Usuário não encontrado');
      return;
    }

    //check if bem already exists if it does, get name of localidade where it is and throw error
    final response = await client
        .from('bens')
        .select('''
      patrimonio,
      inventario_id,
      localidade_id,
      numero_serie,
      descricao,
      localidades (
        nome
      )
    ''')
        .eq('patrimonio', patrimonio)
        .eq('inventario_id', inventarioLocalidadeId)
        .eq('ano_inventario', anoInventario);

    print('response: $response');
    if (response.isNotEmpty) {
      throw BemJaCadastradoException(
          'Bem já cadastrado na localidade ${response[0]['localidades']['nome']}');
    }

    /* await client
        .from('bens')
        .select(
            'patrimonio, inventario_id, localidade_id, numero_serie, descricao')
        .eq('patrimonio', patrimonio)
        .eq('inventario_id', inventarioLocalidadeId)
        .select();

   
 */
    await client.from('bens').insert({
      'usuario_id': usuario.id,
      'localidade_id': localidadeId,
      'inventario_id': inventarioLocalidadeId,
      'patrimonio': patrimonio,
      'numero_serie': numeroSerie,
      'descricao': descricao,
      'estado_bem': estadoBem,
      'bem_particular': bemParticular,
      'indica_desfazimento': indicaDesfazimento,
      'observacoes': observacoes,
      'sem_etiqueta': semEtiqueta,
      'imagem': url,
      'ano_inventario': anoInventario,
    }).select();
  }

  Future<void> updateBem({
    required int id,
    required File? image,
    required int localidadeId,
    required String patrimonio,
    required String numeroSerie,
    required String descricao,
    required String estadoBem,
    required bool bemParticular,
    required bool indicaDesfazimento,
    required String observacoes,
    required bool semEtiqueta,
  }) async {
    String? name;
    String? url;
    if (image != null) {
      name =
          '${DateTime.now().microsecondsSinceEpoch} + ${image.path.split('/').last}';
      String path = patrimonio.isNotEmpty
          ? '$patrimonio/${DateTime.now().microsecondsSinceEpoch}-${UtilService.getFileName(image.path)}'
          : '${DateTime.now().microsecondsSinceEpoch}-${UtilService.getFileName(image.path)}';

      await client.storage.from('inventario').upload(path, image,
          fileOptions: const FileOptions(
            cacheControl: '3600',
            upsert: true,
          ));
      url = client.storage.from('inventario').getPublicUrl(path);

      await client
          .from('bens')
          .update({
            'localidade_id': localidadeId,
            'patrimonio': patrimonio,
            'numero_serie': numeroSerie,
            'descricao': descricao,
            'estado_bem': estadoBem,
            'bem_particular': bemParticular,
            'indica_desfazimento': indicaDesfazimento,
            'observacoes': observacoes,
            'sem_etiqueta': semEtiqueta,
            'imagem': url,
          })
          .eq('id', id)
          .select();
    } else {
      await client
          .from('bens')
          .update({
            'localidade_id': localidadeId,
            'patrimonio': patrimonio,
            'numero_serie': numeroSerie,
            'descricao': descricao,
            'estado_bem': estadoBem,
            'bem_particular': bemParticular,
            'indica_desfazimento': indicaDesfazimento,
            'observacoes': observacoes,
            'sem_etiqueta': semEtiqueta,
          })
          .eq('id', id)
          .select();
    }
  }

  Future<void> excluirBem(int id) async {
    await client.from('bens').delete().eq('id', id).single();
  }

  Future<bool> checkIfBemExists(String patrimonio) async {
    String anoInventario = dotenv.env['ANO_INVENTARIO'] ?? '2024';
    final response = await client.from('bens').select('''
      patrimonio,
      inventario_id,
      localidade_id,
      numero_serie,
      descricao,
      localidades (
        nome
      )
    ''').eq('patrimonio', patrimonio).eq('ano_inventario', anoInventario);
    if (response.isEmpty) return false;

    throw BemJaCadastradoException(
        'Bem já cadastrado na localidade ${response[0]['localidades']['nome']}');
  }

  Future<DescricaoBem?> getDescricaoBem(String numTombamento) async {
    print('getDescricaoBem');
    String apiToken =
        'a9068ec00f579ad12b293bb9334c574dd0dfbf883f74e3e5f942fc5f46ea74ce';
    String url =
        'https://apisig.ifal.edu.br/v3/patrimonio/bens?inicio=0&quantidade=50&num_tombamento=$numTombamento';

    Dio dio = Dio();
    var response = await dio.get(
      url,
      options: Options(
        headers: {
          'Authorization': 'Bearer $apiToken',
        },
      ),
    );

    if (response.statusCode != null &&
        response.statusCode! >= 200 &&
        response.statusCode! < 300 &&
        response.data.length > 0) {
      return DescricaoBem.fromJson(response.data[0]);
    }
    return null;
  }
}
