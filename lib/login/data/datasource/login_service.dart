import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'login_service.g.dart';

@RestApi(parser: Parser.MapSerializable)
abstract class LoginApiService {
  factory LoginApiService(Dio dio) = _LoginApiService;

  @GET("")
  Future<HttpResponse<dynamic>> login();

}
