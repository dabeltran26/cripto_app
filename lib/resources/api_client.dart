import 'package:cripto_app/config/locator.dart';
import 'package:cripto_app/resources/json_reader.dart';
import 'package:dio/dio.dart';

class ApiClient {
  Dio dio = locator<Dio>();

  static Dio addInterceptors(Dio dio) => dio..interceptors.add(LogInterceptor(responseBody: true));

  void setHeader() {
    dio.options.headers['accept'] = 'application/json';
    dio.options.headers['x-cg-demo-api-key'] = JsonReader.getNameConfig('api_key');
    dio.interceptors.add(LogInterceptor(responseBody: true));
  }
}
