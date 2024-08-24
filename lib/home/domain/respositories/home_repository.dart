import 'package:cripto_app/resources/base_state.dart';
import 'package:cripto_app/resources/models/coin_model.dart';

abstract class HomeApiRepository {
  Future<DataState<List<CoinModel>>> getCoins();
}
