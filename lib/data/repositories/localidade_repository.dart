import 'dart:io';

import 'package:inventario_ifal/data/models/localidade.dart';
import 'package:inventario_ifal/data/models/panoramica.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LocalidadeRepository {
  final SupabaseClient supabase = Supabase.instance.client;

  Future<List<Localidade>> getLocalidades() async {
    try {
      final response =
          await supabase.from('view_inventario_localidade').select();
      if (response.isEmpty) {
        return [];
      }
      return response.map((e) => Localidade.fromJson(e)).toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<Localidade> buscaDetalhesLocalidade(int id) async {
    try {
      final response = await supabase
          .from('view_inventario_localidade')
          .select()
          .eq('localidade_id', id)
          .single();

      return Localidade.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  Future<Localidade> salvarPanoramicas(
      {required List<File> imagens, required Localidade localidade}) async {
    try {
      List<Future> futures = [];
      imagens.forEach((imagem) async {
        String name =
            '${DateTime.now().microsecondsSinceEpoch} + ${imagem.path.split('/').last}';
        String path =
            '${localidade.localidadeId.toString()}/panoramicas/${DateTime.now().microsecondsSinceEpoch}-${imagem.path.split('/').last}';
        String url = await supabase.storage.from('inventario').upload(
            path, imagem,
            fileOptions: FileOptions(cacheControl: '3600', upsert: true));
        futures.add(supabase.from('panoramicas').insert({
          'inventario_id': localidade.inventarioId,
          'path_file': path,
          'url': url,
        }));
      });
      await Future.wait(futures);
      return localidade;
    } catch (e) {
      rethrow;
    }
  }

  Future excluirPanoramica(Panoramica panoramica) async {
    try {
      await supabase
          .from('panoramicas')
          .delete()
          .eq('inventario_id', panoramica.inventarioId)
          .select();
    } catch (e) {
      rethrow;
    }
  }
}
