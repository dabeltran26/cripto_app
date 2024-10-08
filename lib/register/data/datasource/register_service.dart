import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'register_service.g.dart';

@RestApi(parser: Parser.MapSerializable)
abstract class RegisterApiService {
  factory RegisterApiService(Dio dio) = _RegisterApiService;

  @POST('')
  Future<HttpResponse<dynamic>> signUp();
}
