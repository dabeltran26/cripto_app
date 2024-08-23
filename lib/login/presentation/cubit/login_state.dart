part of 'package:cripto_app/login/presentation/cubit/login_cubit.dart';

abstract class LoginState extends Equatable {
  final String? data;
  final String? errorMessage;
  final DioError? error;

  const LoginState({
    this.data,
    this.errorMessage,
    this.error,
  });

  @override
  List<Object?> get props => [data, errorMessage, error];
}

class LoginInitial extends LoginState {
  final String? errorMessage;
  const LoginInitial(this.errorMessage);
}

class LoginLoading extends LoginState {
  const LoginLoading();
}

class LoginSuccess extends LoginState {
  const LoginSuccess();
}

class LoginFailed extends LoginState {
  const LoginFailed({error});
}
