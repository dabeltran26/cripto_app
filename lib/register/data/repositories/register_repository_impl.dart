import 'package:cripto_app/register/data/datasource/firebase_register_service.dart';
import 'package:cripto_app/register/data/datasource/register_service.dart';
import 'package:cripto_app/register/domain/models/register.request.dart';
import 'package:cripto_app/register/domain/repositories/register_repository.dart';
import 'package:cripto_app/resources/base_api_repository.dart';
import 'package:cripto_app/resources/base_state.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterRepositoryImpl extends BaseApiRepository implements RegisterApiRepository {
  final RegisterApiService _apiService;
  final FirebaseRegisterServices firebaseLoginServices;

  RegisterRepositoryImpl(this._apiService, this.firebaseLoginServices);

  @override
  Future<UserCredential> signUpCredentials(String email, String password) async {
    return await firebaseLoginServices.signUpCredentials(email, password);
  }
}
