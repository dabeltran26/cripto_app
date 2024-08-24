import 'package:cripto_app/home/data/datasource/home_service.dart';
import 'package:cripto_app/home/domain/respositories/home_repository.dart';
import 'package:cripto_app/resources/base_api_repository.dart';
import 'package:cripto_app/resources/base_state.dart';
import 'package:cripto_app/resources/models/coin_model.dart';

class HomeRepositoryImpl extends BaseApiRepository implements HomeApiRepository {
  final HomeApiService _apiService;

  HomeRepositoryImpl(this._apiService);

  @override
  Future<DataState<List<CoinModel>>> getCoins() {
    return getStateOf<List<CoinModel>>(
      request: () => _apiService.getCoins(),
    );
  }
}
