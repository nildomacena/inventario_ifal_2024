import 'package:supabase_flutter/supabase_flutter.dart';

class RemoteDataSource {
  final SupabaseClient _supabaseClient;

  RemoteDataSource(this._supabaseClient);

  /// Autenticação de usuário
  Future<User?> signIn(String email, String password) async {
    final response = await _supabaseClient.auth
        .signInWithPassword(email: email, password: password);
    return response.user;
  }

  /// Registro de usuário
  Future<User?> signUp(String email, String password) async {
    final response = await _supabaseClient.auth.signUp(email, password);
    if (response.error != null) {
      throw Exception(response.error!.message);
    }
    return response.user;
  }

  /// Logout de usuário
  Future<void> signOut() async {
    final response = await _supabaseClient.auth.signOut();
    if (response.error != null) {
      throw Exception(response.error!.message);
    }
  }

  /// Busca de dados
  Future<List<Map<String, dynamic>>> fetchData(String tableName) async {
    final response = await _supabaseClient.from(tableName).select().execute();
    if (response.error != null) {
      throw Exception(response.error!.message);
    }
    return List<Map<String, dynamic>>.from(response.data);
  }

  /// Adicionar novo registro
  Future<void> addData(String tableName, Map<String, dynamic> data) async {
    final response =
        await _supabaseClient.from(tableName).insert(data).execute();
    if (response.error != null) {
      throw Exception(response.error!.message);
    }
  }

  /// Atualizar registro
  Future<void> updateData(
      String tableName, Map<String, dynamic> data, String id) async {
    final response = await _supabaseClient
        .from(tableName)
        .update(data)
        .eq('id', id)
        .execute();
    if (response.error != null) {
      throw Exception(response.error!.message);
    }
  }

  /// Deletar registro
  Future<void> deleteData(String tableName, String id) async {
    final response =
        await _supabaseClient.from(tableName).delete().eq('id', id).execute();
    if (response.error != null) {
      throw Exception(response.error!.message);
    }
  }
}
