part of 'package:cripto_app/favorites/presentation/cubit/favorite_cubit.dart';

abstract class FavoriteState extends Equatable {
  final String? userName;
  final List<CoinModel>? coins;
  final String? errorMessage;
  final DioError? error;

  const FavoriteState({
    this.userName,
    this.coins,
    this.errorMessage,
    this.error,
  });

  @override
  List<Object?> get props => [userName, coins, errorMessage, error];
}

class FavoriteInitial extends FavoriteState {}

class FavoriteLoading extends FavoriteState {
  const FavoriteLoading();
}

class FavoriteSuccess extends FavoriteState {
  final List<CoinModel> coins;

  const FavoriteSuccess(this.coins);
}

class FavoriteFailed extends FavoriteState {
  final String? errorMessage;

  const FavoriteFailed(this.errorMessage);
}
