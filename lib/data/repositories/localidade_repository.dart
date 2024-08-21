import 'package:inventario_ifal/data/models/localidade.dart';
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
}
