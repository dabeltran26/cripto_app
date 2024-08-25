import 'package:cripto_app/register/domain/repositories/register_repository.dart';
import 'package:cripto_app/resources/base_cubit.dart';
import 'package:cripto_app/resources/hive_service.dart';
import 'package:cripto_app/resources/models/user_model.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'package:cripto_app/register/presentation/cubit/register_state.dart';

class RegisterCubit extends BaseCubit<RegisterState> {
  final RegisterApiRepository _apiRepository;

  RegisterCubit(this._apiRepository) : super(const RegisterInitial(''));

  Future<void> registerWitchCredentials(
      Function navigate, String email, String password, String name, int age, DateTime birthday) async {
    emit(const RegisterLoading());
    try {
      UserCredential responseFirebase = await _apiRepository.signUpCredentials(email, password);
      if (responseFirebase.user != null) {
        var user = UserModel(
            email: email,
            name: name,
            birthday: birthday,
            age: age,
            uid: responseFirebase.user!.uid);
        if (await _apiRepository.saveUser(user)) {
          HiveService.saveFirebaseToken(responseFirebase.user!.uid);
          HiveService.saveUser(user);
          navigate();
        } else {
          emit(const RegisterInitial('Hubo un error inesperado.'));
        }
      } else {
        emit(const RegisterInitial('Hubo un error inesperado.'));
      }
    } catch (_) {
      emit(const RegisterInitial('Hubo un error inesperado'));
    }
  }
}
