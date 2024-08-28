import 'package:cripto_app/resources/models/coin_model.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'favorite_service.g.dart';

@RestApi(parser: Parser.MapSerializable)
abstract class FavoriteApiService {
  factory FavoriteApiService(Dio dio) = _FavoriteApiService;

  @GET("/coins/markets?vs_currency=usd")
  Future<HttpResponse<List<CoinModel>>> getCoins();
}
