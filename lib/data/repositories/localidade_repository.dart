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

  Future<dynamic> buscaDetalhesLocalidade(int id) async {
    try {
      //busca a na view inventario_por_localidade os dados
      // final response = await await supabase
      //     .rpc('detalhes_localidade', params: {'localidade_id_input': id});
      final response = await supabase
          .from('Vw_InventarioDetalhado2')
          .select()
          .eq('localidade_id', id);

      print(response);
    } catch (e) {
      rethrow;
    }
  }
}
