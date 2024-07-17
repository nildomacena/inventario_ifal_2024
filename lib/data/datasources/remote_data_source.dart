import 'package:supabase_flutter/supabase_flutter.dart';

class RemoteDataSource {
  static const String usersTable = 'users';

  final SupabaseClient _supabaseClient;

  RemoteDataSource(this._supabaseClient);

  Future<User?> signIn(String email, String password) async {
    final response = await _supabaseClient.auth
        .signInWithPassword(email: email, password: password);
    return response.user;
  }

  Future<void> signUpUser(String email, String password, String name,
      String siape, String cpf) async {
    final userResponse =
        await _supabaseClient.auth.signUp(email: email, password: password);

    final userId = userResponse.user!.id;
    final profileResponse = await _supabaseClient.from(usersTable).insert(
        {'id': userId, 'name': name, 'siape': siape, 'cpf': cpf}).single();
  }

  Future<Map<String, dynamic>> fetchUser(String userId) async {
    final response =
        await _supabaseClient.from('users').select().eq('id', userId).single();

    return response;
  }

  Future<void> signOut() async {
    return _supabaseClient.auth.signOut();
  }

  Future<List<Map<String, dynamic>>> fetchData(String tableName) async {
    final response = await _supabaseClient.from(tableName).select().single();
    return List<Map<String, dynamic>>.from(response.values);
  }

  Future<void> addData(String tableName, Map<String, dynamic> data) async {
    await _supabaseClient.from(tableName).insert(data).single();
    return;
  }

  Future<void> updateData(
      String tableName, Map<String, dynamic> data, String id) async {
    await _supabaseClient.from(tableName).update(data).eq('id', id).single();
    return;
  }

  Future<void> deleteData(String tableName, String id) async {
    await _supabaseClient.from(tableName).delete().eq('id', id).single();
    return;
  }
}
