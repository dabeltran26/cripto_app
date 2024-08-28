import 'package:cripto_app/home/data/datasource/firebase_home_service.dart';
import 'package:cripto_app/home/data/datasource/home_service.dart';
import 'package:cripto_app/home/domain/respositories/home_repository.dart';
import 'package:cripto_app/resources/base_api_repository.dart';
import 'package:cripto_app/resources/base_state.dart';
import 'package:cripto_app/resources/models/coin_model.dart';

class HomeRepositoryImpl extends BaseApiRepository implements HomeApiRepository {
  final HomeApiService apiService;
  final FirebaseHomeServices firebaseHomeServices;

  HomeRepositoryImpl(this.apiService, this.firebaseHomeServices);

  @override
  Future<DataState<List<CoinModel>>> getCoins() {
    return getStateOf<List<CoinModel>>(
      request: () => apiService.getCoins(),
    );
  }

  @override
  Future<bool> saveFavorite(String uid, CoinModel coin) async {
    return await firebaseHomeServices.saveFavorite(uid, coin);
  }
}
