import 'package:cripto_app/login/data/datasource/login_service.dart';
import 'package:cripto_app/login/data/repositories/login_repository_impl.dart';
import 'package:cripto_app/login/domain/respositories/login_repository.dart';
import 'package:cripto_app/resources/firebase_service.dart';
import 'package:cripto_app/resources/json_reader.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

Future<void> initializeDependencies() async {
  final dio = Dio(BaseOptions(
    baseUrl: JsonReader.getNameConfig('base_url'),
    responseType: ResponseType.json,
    contentType: 'application/json',
  ));

  locator.registerSingleton<Dio>(dio);

  locator.registerSingleton<FirebaseServices>(
    FirebaseServices(),
  );

  //LOGIN
  locator.registerSingleton<LoginApiService>(
    LoginApiService(locator<Dio>()),
  );
  locator.registerSingleton<LoginApiRepository>(
    LoginRepositoryImpl(locator<LoginApiService>()),
  );
}
