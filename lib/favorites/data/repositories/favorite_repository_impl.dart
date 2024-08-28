import 'package:cripto_app/favorites/data/datasource/favorite_service.dart';
import 'package:cripto_app/favorites/data/datasource/firebase_favorite_service.dart';
import 'package:cripto_app/favorites/domain/respositories/favorite_repository.dart';
import 'package:cripto_app/resources/base_api_repository.dart';
import 'package:cripto_app/resources/base_state.dart';
import 'package:cripto_app/resources/models/coin_model.dart';

class FavoriteRepositoryImpl extends BaseApiRepository implements FavoriteApiRepository {
  final FavoriteApiService apiService;
  final FirebaseFavoriteServices firebaseHomeServices;

  FavoriteRepositoryImpl(this.apiService, this.firebaseHomeServices);

  @override
  Future<DataState<List<CoinModel>>> getCoins() {
    return getStateOf<List<CoinModel>>(
      request: () => apiService.getCoins(),
    );
  }

  @override
  Future<bool> deleteFavorite(String uid, CoinModel coin) async {
    return await firebaseHomeServices.deleteFavorite(uid, coin);
  }

  @override
  Future<List<CoinModel>> getFavoritesCoins(String uid) async {
    return await firebaseHomeServices.getFavoriteProducts(uid);
  }
}
