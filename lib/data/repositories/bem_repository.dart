import 'dart:io';

import 'package:supabase_flutter/supabase_flutter.dart';

class BemRepository {
  SupabaseClient client = Supabase.instance.client;

  Future<void> createBem({
    required File image,
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
    String name =
        '${DateTime.now().microsecondsSinceEpoch} + ${image.path.split('/').last}';
    String url =
        await client.storage.from('inventario').upload('patrimonio', image);

    await client.from('bens').upsert({
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
    }).single();
  }

  Future<void> updateBem({
    required int id,
    required File image,
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
    String name =
        '${DateTime.now().microsecondsSinceEpoch} + ${image.path.split('/').last}';
    String url = await client.storage.from('bens').upload(name, image);

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
        .single();
  }

  Future<void> excluirBem(int id) async {
    await client.from('bens').delete().eq('id', id).single();
  }
}
