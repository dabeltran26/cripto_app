part of 'package:cripto_app/register/presentation/cubit/register_cubit.dart';

abstract class RegisterState extends Equatable {
  final String? data;
  final String? errorMessage;
  final DioError? error;

  const RegisterState({
    this.data,
    this.errorMessage,
    this.error,
  });

  @override
  List<Object?> get props => [data, errorMessage, error];
}

class RegisterInitial extends RegisterState {
  final String? errorMessage;
  const RegisterInitial(this.errorMessage);
}

class RegisterLoading extends RegisterState {
  const RegisterLoading();
}

class RegisterSuccess extends RegisterState {
  const RegisterSuccess();
}

class RegisterFailed extends RegisterState {
  const RegisterFailed({error});
}
