part of 'package:cripto_app/profile/presentation/cubit/profile_cubit.dart';

abstract class ProfileState extends Equatable {
  final String? data;
  final String? errorMessage;
  final DioError? error;

  const ProfileState({
    this.data,
    this.errorMessage,
    this.error,
  });

  @override
  List<Object?> get props => [data, errorMessage, error];
}

class ProfileInitial extends ProfileState {
  const ProfileInitial();
}

class ProfileLoading extends ProfileState {
  const ProfileLoading();
}

class ProfileSuccess extends ProfileState {
  const ProfileSuccess();
}

class ProfileFailed extends ProfileState {
  final String? errorMessage;

  const ProfileFailed(this.errorMessage);
}
