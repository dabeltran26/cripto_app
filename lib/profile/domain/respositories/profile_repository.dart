import 'package:cripto_app/resources/models/user_model.dart';

abstract class ProfileApiRepository {
  Future<bool> updatePassword(String password);

  Future<bool> updateUser(UserModel user);
}
