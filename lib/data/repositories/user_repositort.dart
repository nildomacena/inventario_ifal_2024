import 'package:inventario_ifal/domain/entities/user.dart';

abstract class UserRepository {
  Future<void> signUpUser(
      String email, String password, String name, String siape, String cpf);
  Future<UserData> loginUser(String email, String password);
}
