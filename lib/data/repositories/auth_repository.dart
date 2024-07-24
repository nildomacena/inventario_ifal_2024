import 'package:inventario_ifal/data/models/usuario.dart';
import 'package:inventario_ifal/data/providers/auth_provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthRepository {
  AuthProvider authProvider;

  AuthRepository({required this.authProvider});

  Future<Usuario?> login({
    required String email,
    required String password,
  }) async {
    try {
      Usuario? response = await authProvider.login(email, password);

      if (response == null) {
        return null;
      }

      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Usuario?> getUsuario(String id) async {
    try {
      Usuario? response = await authProvider.getUsuario(id);

      if (response == null) {
        return null;
      }

      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Usuario?> signUp({
    required String email,
    required String password,
    required String name,
    required String cpf,
    required String siape,
  }) async {
    try {
      User? response = await authProvider.signUp(
        email: email,
        password: password,
        name: name,
        cpf: cpf,
        siape: siape,
      );

      if (response == null) {
        return throw Exception('Erro ao criar usuário');
      }

      return getUsuario(response.id);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> signOut() async {
    try {
      await authProvider.signOut();
    } catch (e) {
      rethrow;
    }
  }
}
