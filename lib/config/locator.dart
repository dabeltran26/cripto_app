import 'package:cripto_app/login/data/datasource/firebase_login_service.dart';
import 'package:cripto_app/login/data/datasource/login_service.dart';
import 'package:cripto_app/login/data/repositories/login_repository_impl.dart';
import 'package:cripto_app/login/domain/respositories/login_repository.dart';
import 'package:cripto_app/register/data/datasource/firebase_register_service.dart';
import 'package:cripto_app/register/data/datasource/register_service.dart';
import 'package:cripto_app/register/data/repositories/register_repository_impl.dart';
import 'package:cripto_app/register/domain/repositories/register_repository.dart';
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

  //LOGIN
  locator.registerSingleton<LoginApiService>(
    LoginApiService(locator<Dio>()),
  );

  locator.registerSingleton<FirebaseLoginService>(
    FirebaseLoginService(),
  );

  locator.registerSingleton<LoginApiRepository>(
    LoginRepositoryImpl(locator<LoginApiService>(), locator<FirebaseLoginService>()),
  );

  //REGISTER
  locator.registerSingleton<RegisterApiService>(
    RegisterApiService(locator<Dio>()),
  );

  locator.registerSingleton<FirebaseRegisterServices>(
    FirebaseRegisterServices(),
  );

  locator.registerSingleton<RegisterApiRepository>(
    RegisterRepositoryImpl(locator<RegisterApiService>(), locator<FirebaseRegisterServices>()),
  );
}
