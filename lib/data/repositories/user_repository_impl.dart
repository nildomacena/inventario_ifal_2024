// arquivo: lib/data/repositories/user_repository_impl.dart

import 'package:inventario_ifal/data/datasources/remote_data_source.dart';
import 'package:inventario_ifal/data/repositories/user_repositort.dart';
import 'package:inventario_ifal/domain/entities/user.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UserRepositoryImpl implements UserRepository {
  final RemoteDataSource dataSource;

  UserRepositoryImpl(this.dataSource);

  @override
  Future<UserData> loginUser(String email, String password) async {
    final User? user = await dataSource.signIn(email, password);
    if (user == null) {
      throw Exception('Usuário não encontrado');
    }
    final userData = await dataSource.fetchUser(user.id);
    return UserData.fromJson(userData);
  }

  @override
  Future<void> signUpUser(
      String email, String password, String name, String siape, String cpf) {
    return dataSource.signUpUser(email, password, name, siape, cpf);
  }
}
