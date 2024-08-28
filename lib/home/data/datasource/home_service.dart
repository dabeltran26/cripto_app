import 'package:cripto_app/resources/models/coin_model.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'home_service.g.dart';

@RestApi(parser: Parser.MapSerializable)
abstract class HomeApiService {
  factory HomeApiService(Dio dio) = _HomeApiService;

  @GET("/coins/markets?vs_currency=usd")
  Future<HttpResponse<List<CoinModel>>> getCoins();
}
