import 'dart:io';

import 'package:inventario_ifal/data/models/localidade.dart';
import 'package:inventario_ifal/data/models/panoramica.dart';
import 'package:inventario_ifal/shared/utils.dart';
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
      List<Future> futures = imagens.map((imagem) async {
        String path =
            '${localidade.localidadeId}/${DateTime.now().microsecondsSinceEpoch}-${UtilService.getFileName(imagem.path)}';

        await supabase.storage.from('inventario').upload(path, imagem,
            fileOptions: const FileOptions(
              cacheControl: '3600',
              upsert: true,
            ));
        String url = supabase.storage.from('inventario').getPublicUrl(path);

        await supabase.from('fotos_panoramicas').insert({
          'inventario_id': localidade.inventarioId,
          'path_file': path,
          'url': url,
        }).select();
      }).toList();
      var result = await Future.wait(futures);
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

  Future<List<Panoramica>> getPanoramicas(int inventarioId) async {
    try {
      final response = await supabase
          .from('fotos_panoramicas')
          .select()
          .eq('inventario_id', inventarioId);
      if (response.isEmpty) {
        return [];
      }
      return response.map((e) => Panoramica.fromJson(e)).toList();
    } catch (e) {
      rethrow;
    }
  }

  finalizarLocalidade({
    required int localidadeId,
    required int usuarioId,
    required File imagem,
    required String observacao,
  }) async {
    try {
      String path =
          '$localidadeId/relatorio-${UtilService.getFileName(imagem.path)}';

      await supabase.storage.from('inventario').upload(path, imagem,
          fileOptions: const FileOptions(
            cacheControl: '3600',
            upsert: true,
          ));
      String url = supabase.storage.from('inventario').getPublicUrl(path);
      String date = DateTime.now().toIso8601String();

      await supabase
          .from('inventario_localidade')
          .update({
            'observacao': observacao,
            'relatorio_path': path,
            'relatorio': url,
            'status': 'finalizada',
            'usuario_id': usuarioId,
          })
          .eq('localidade_id', localidadeId)
          .select();
    } catch (e) {
      rethrow;
    }
  }
}
