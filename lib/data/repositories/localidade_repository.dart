import 'package:inventario_ifal/data/models/localidade.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LocalidadeRepository {
  final SupabaseClient supabase = Supabase.instance.client;

  Future<List<Localidade>> getLocalidades() async {
    try {
      final response = await supabase.from('localidades').select();
      if (response.isEmpty) {
        return [];
      }
      return response.map((e) => Localidade.fromJson(e)).toList();
    } catch (e) {
      rethrow;
    }
  }
}
