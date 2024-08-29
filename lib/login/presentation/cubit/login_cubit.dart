import 'package:cripto_app/login/domain/models/login.request.dart';
import 'package:cripto_app/login/domain/respositories/login_repository.dart';
import 'package:cripto_app/resources/base_cubit.dart';
import 'package:cripto_app/resources/hive_service.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'package:cripto_app/login/presentation/cubit/login_state.dart';

class LoginCubit extends BaseCubit<LoginState> {
  final LoginApiRepository _apiRepository;
  String data = '';
  late LoginRequest loginRequest;

  LoginCubit(this._apiRepository) : super(const LoginInitial(''));

  /*Future<void> loginWitchGoogle(Function navigate) async {
    emit(const LoginLoading());
    try {
      bool responseFirebase = await _apiRepository.signInWithGoogle();
      if (responseFirebase) {
        emit(const LoginInitial('Todo melo'));
      } else {
        emit(const LoginInitial('Ocurrio un error'));
      }
    } catch (_) {
      emit(const LoginInitial('Ocurrio un error'));
    }
  }*/

  Future<void> loginWitchCredentials(Function navigate, String email, String password) async {
    emit(const LoginLoading());
    try {
      UserCredential user = await _apiRepository.signInWithCredentials(email, password);
      var userData = await _apiRepository.getUserInfo(user.user!.uid);
      if (userData != null) {
        HiveService.saveFirebaseToken(userData.uid);
        HiveService.saveUser(userData);
        navigate();
        emit(const LoginInitial('Todo melo'));
      } else {
        emit(const LoginInitial('No se encontró usuario.'));
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        emit(const LoginInitial('No se encontró usuario.'));
      } else if (e.code == 'wrong-password') {
        emit(const LoginInitial('Credenciales incorrectas.'));
      } else {
        emit(LoginInitial(e.code));
      }
    } catch (e) {
      emit(LoginInitial('hubo errro $e'));
    }
  }
}
