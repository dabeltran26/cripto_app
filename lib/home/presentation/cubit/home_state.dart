part of 'package:cripto_app/home/presentation/cubit/home_cubit.dart';

abstract class HomeState extends Equatable {
  final String? userName;
  final List<CoinModel>? coins;
  final String? errorMessage;
  final DioError? error;

  const HomeState({
    this.userName,
    this.coins,
    this.errorMessage,
    this.error,
  });

  @override
  List<Object?> get props => [userName, coins, errorMessage, error];
}

class HomeInitial extends HomeState {
  final String? errorMessage;

  const HomeInitial(this.errorMessage);
}

class HomeLoading extends HomeState {
  const HomeLoading();
}

class HomeSuccess extends HomeState {
  final List<CoinModel> coins;

  const HomeSuccess(this.coins);
}

class HomeFailed extends HomeState {
  const HomeFailed({error});
}
