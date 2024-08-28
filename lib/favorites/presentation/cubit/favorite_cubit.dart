import 'package:cripto_app/favorites/domain/respositories/favorite_repository.dart';
import 'package:cripto_app/resources/base_cubit.dart';
import 'package:cripto_app/resources/base_state.dart';
import 'package:cripto_app/resources/hive_service.dart';
import 'package:cripto_app/resources/models/coin_model.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

part 'package:cripto_app/favorites/presentation/cubit/favorite_state.dart';

class FavoriteCubit extends BaseCubit<FavoriteState> {
  final FavoriteApiRepository apiRepository;
  late List<CoinModel> favoriteCoins;
  late List<CoinModel> allCoins;
  List<CoinModel> finalCoins = [];
  String uid = HiveService.getFirebaseToken();

  FavoriteCubit(this.apiRepository) : super(const FavoriteLoading());

  Future<void> getFavoriteCoins() async {
    try {
      emit(const FavoriteLoading());
      finalCoins = [];
      favoriteCoins = [];
      allCoins = [];

      var response = await apiRepository.getCoins();
      favoriteCoins = await apiRepository.getFavoritesCoins(uid);

      if (response is DataSuccess && favoriteCoins.isNotEmpty) {
        allCoins = response.data!;

        Set<String?> favoriteIds = favoriteCoins.map((coin) => coin.id).toSet();

        for (var coin in allCoins) {
          if (favoriteIds.contains(coin.id)) {
            finalCoins.add(coin);
          }
        }

        emit(FavoriteSuccess(finalCoins));
      } else {
        emit(FavoriteSuccess(finalCoins));
      }
    } catch (e) {
      emit(const FavoriteFailed('Hubo un error inesperado.'));
    }
  }

  void deleteFavoriteCoin(CoinModel coin, Function success) async {
    try {
      if (await apiRepository.deleteFavorite(uid, coin)) {
        getFavoriteCoins();
        success();
      }
    } catch (e) {
      print(e);
    }
  }
}
