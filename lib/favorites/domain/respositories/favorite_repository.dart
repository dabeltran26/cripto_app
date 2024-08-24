import 'package:cripto_app/resources/base_state.dart';
import 'package:cripto_app/resources/models/coin_model.dart';

abstract class FavoriteApiRepository {
  Future<DataState<List<CoinModel>>> getCoins();

  Future<bool> deleteFavorite(String uid, CoinModel coin);

  Future<List<CoinModel>> getFavoritesCoins(String uid);
}
