import 'package:cripto_app/register/data/datasource/firebase_register_service.dart';
import 'package:cripto_app/register/domain/repositories/register_repository.dart';
import 'package:cripto_app/resources/base_cubit.dart';
import 'package:cripto_app/resources/hive_service.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'package:cripto_app/register/presentation/cubit/register_state.dart';

class RegisterCubit extends BaseCubit<RegisterState> {
  final RegisterApiRepository _apiRepository;

  RegisterCubit(this._apiRepository) : super(const RegisterInitial(''));

  Future<void> registerWitchCredentials(Function navigate, String email, String password, String name) async {
    emit(const RegisterLoading());
    try {
      UserCredential responseFirebase = await _apiRepository.signUpCredentials(email, password);
      if (responseFirebase.user != null) {
        //HiveService.saveFirebaseToken(responseFirebase.user!.uid);
        navigate();
      } else {
        emit(const RegisterInitial('Hubo un error inesperado.'));
      }
    } catch (_) {
      emit(const RegisterInitial('Hubo un error inesperado'));
    }
  }
}
