import 'package:cripto_app/login/domain/models/login.request.dart';
import 'package:cripto_app/login/domain/models/user_google_model.dart';
import 'package:cripto_app/login/domain/respositories/login_repository.dart';
import 'package:cripto_app/resources/base_cubit.dart';
import 'package:cripto_app/resources/firebase_service.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'package:cripto_app/login/presentation/cubit/login_state.dart';

class LoginCubit extends BaseCubit<LoginState> {
  final LoginApiRepository _apiRepository;
  String data = '';
  late LoginRequest loginRequest;
  FirebaseServices firebaseLogin = FirebaseServices();

  LoginCubit(this._apiRepository) : super(const LoginInitial(''));

  Future<void> loginWitchGoogle(Function navigate) async {
    emit(const LoginLoading());
    try {
      bool responseFirebase = await firebaseLogin.signInWithGoogle();
      if (responseFirebase) {
        UserGoogleModel user = await firebaseLogin.getUser();
        emit(const LoginInitial('Todo melo'));
      } else {
        emit(const LoginInitial('Ocurrio un error'));
      }
    } catch (_) {
      emit(const LoginInitial('Ocurrio un error'));
    }
  }

  Future<void> loginWitchCredentials(Function navigate, String email, String password) async {
    emit(const LoginLoading());
    try {
      await firebaseLogin.signInWithCredentials(email, password);
      UserGoogleModel user = await firebaseLogin.getUser();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        emit(const LoginInitial('No se encontró usuario.'));
      } else if (e.code == 'wrong-password') {
        emit(const LoginInitial('Credenciales incorrectas.'));
      } else {
        emit(const LoginInitial('Credenciales incorrectas.'));
      }
    } catch (_) {
      emit(const LoginInitial('Hubo un error inesperado'));
    }
  }
}
