import 'package:cripto_app/resources/base_state.dart';
import 'package:cripto_app/resources/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class LoginApiRepository {
  Future<bool> signInWithGoogle();

  Future<UserCredential> signInWithCredentials(String email, String password);

  Future<UserModel?> getUserInfo(String uid);
}
