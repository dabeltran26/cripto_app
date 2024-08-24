import 'package:cripto_app/resources/base_state.dart';
import 'package:cripto_app/resources/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class RegisterApiRepository {
  Future<UserCredential> signUpCredentials(String email, String password);

  Future<bool> saveUser(UserModel user);
}
