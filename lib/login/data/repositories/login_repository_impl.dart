import 'package:cripto_app/login/data/datasource/firebase_login_service.dart';
import 'package:cripto_app/login/data/datasource/login_service.dart';
import 'package:cripto_app/login/domain/respositories/login_repository.dart';
import 'package:cripto_app/resources/base_api_repository.dart';
import 'package:cripto_app/resources/base_state.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginRepositoryImpl extends BaseApiRepository implements LoginApiRepository {
  final LoginApiService _apiService;
  final FirebaseLoginService firebaseLoginServices;

  LoginRepositoryImpl(this._apiService, this.firebaseLoginServices);

  @override
  Future<bool> signInWithGoogle() async {
    return await firebaseLoginServices.signInWithGoogle();
  }

  @override
  Future<UserCredential> signInWithCredentials(String email, String password) async {
    return await firebaseLoginServices.signInWithCredentials(email, password);
  }
}
