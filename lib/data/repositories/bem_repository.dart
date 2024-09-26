import 'dart:io';

import 'package:get/get.dart';
import 'package:inventario_ifal/data/models/bem.dart';
import 'package:inventario_ifal/data/models/usuario.dart';
import 'package:inventario_ifal/data/providers/auth_provider.dart';
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
}
