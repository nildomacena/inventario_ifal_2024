import 'package:inventario_ifal/data/models/usuario.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthProvider {
  final supabase = Supabase.instance.client;
  Usuario? usuario;

  Future<Usuario?> login(String username, String password) async {
    try {
      final response = await supabase.auth.signInWithPassword(
        email: username,
        password: password,
      );

      if (response.user == null) {
        return null;
      }
      listenAuthState();
      return getUsuario(response.user!.id);
    } catch (e) {
      rethrow;
    }
  }

  listenAuthState() {
    supabase.auth.onAuthStateChange.listen((event) {
      if (event.session?.user != null) {
        getUsuario(event.session!.user.id).then((value) {
          usuario = value;
        });
      } else {
        usuario = null;
      }
    }, onError: (e) {
      usuario = null;
      supabase.auth.signOut();
    });
  }

  Future<Usuario?> getUsuario(String id) async {
    try {
      final response =
          await supabase.from('usuarios').select().eq('uid', id).single();

      if (response.isEmpty) {
        return null;
      }

      return Usuario.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  Future<User?> signUp({
    required String email,
    required String password,
    required String name,
    required String cpf,
    required String siape,
  }) async {
    late AuthResponse response;
    try {
      response = await supabase.auth.signUp(email: email, password: password);

      if (response.user == null) {
        return throw Exception('Erro ao criar usuário');
      }

      await supabase.from('usuarios').insert({
        'uid': response.user!.id,
        'nome': name,
        'cpf': cpf,
        'siape': siape,
        'email': email,
      }).single();

      listenAuthState();

      return response.user;
    } catch (e) {
      supabase.auth.admin.deleteUser(response.user!.id);
      rethrow;
    }
  }

  Future<void> signOut() async {
    try {
      await supabase.auth.signOut();
    } catch (e) {
      rethrow;
    }
  }

  Future<User?> getCurrentUser() async {
    try {
      return supabase.auth.currentUser;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> resetPassword(String email) async {
    try {
      await supabase.auth.resetPasswordForEmail(email);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateProfile({
    required String name,
    required String cpf,
    required String siape,
  }) async {
    try {
      await supabase.from('usuarios').upsert([
        {
          'id': supabase.auth.currentUser!.id,
          'nome': name,
          'cpf': cpf,
          'siape': siape,
        }
      ]).single();
    } catch (e) {
      rethrow;
    }
  }
}
