import 'package:cripto_app/profile/domain/respositories/profile_repository.dart';
import 'package:cripto_app/resources/base_cubit.dart';
import 'package:cripto_app/resources/hive_service.dart';
import 'package:cripto_app/resources/models/user_model.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

part 'package:cripto_app/profile/presentation/cubit/profile_state.dart';

class ProfileCubit extends BaseCubit<ProfileState> {
  final ProfileApiRepository apiRepository;
  late UserModel user;

  ProfileCubit(this.apiRepository) : super(const ProfileLoading());

  Future<void> getUser() async {
    emit(const ProfileLoading());
    try {
      user = HiveService.getUser();
    } catch (e) {
      emit(const ProfileFailed('Hubo un error inesperado'));
    }

    emit(const ProfileSuccess());
  }

  Future<void> updatePassword(String password, Function alert) async {
    emit(const ProfileLoading());
    try {
      await apiRepository.updatePassword(password);
      emit(const ProfileSuccess());
    } catch (e) {
      emit(const ProfileFailed('Hubo un error inesperado'));
    }
  }

  Future<void> updateUser(UserModel user, Function alert) async {
    emit(const ProfileLoading());
    try {
      if (await apiRepository.updateUser(user)) {
        HiveService.saveUser(user);
        emit(const ProfileSuccess());
      } else {
        emit(const ProfileFailed('Hubo un error inesperado'));
      }
    } catch (e) {
      emit(const ProfileFailed('Hubo un error inesperado'));
    }
  }
}
