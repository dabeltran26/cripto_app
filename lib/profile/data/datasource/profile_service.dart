import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'profile_service.g.dart';

@RestApi(parser: Parser.MapSerializable)
abstract class ProfileApiService {
  factory ProfileApiService(Dio dio) = _ProfileApiService;

  @GET("")
  Future<HttpResponse<dynamic>> login();

}
