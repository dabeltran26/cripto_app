import 'package:cripto_app/favorites/data/datasource/favorite_service.dart';
import 'package:cripto_app/favorites/data/datasource/firebase_favorite_service.dart';
import 'package:cripto_app/favorites/data/repositories/favorite_repository_impl.dart';
import 'package:cripto_app/favorites/domain/respositories/favorite_repository.dart';
import 'package:cripto_app/home/data/datasource/firebase_home_service.dart';
import 'package:cripto_app/home/data/datasource/home_service.dart';
import 'package:cripto_app/home/data/repositories/home_repository_impl.dart';
import 'package:cripto_app/home/domain/respositories/home_repository.dart';
import 'package:cripto_app/login/data/datasource/firebase_login_service.dart';
import 'package:cripto_app/login/data/datasource/login_service.dart';
import 'package:cripto_app/login/data/repositories/login_repository_impl.dart';
import 'package:cripto_app/login/domain/respositories/login_repository.dart';
import 'package:cripto_app/profile/data/datasource/firebase_profile_service.dart';
import 'package:cripto_app/profile/data/datasource/profile_service.dart';
import 'package:cripto_app/profile/data/repositories/profile_repository_impl.dart';
import 'package:cripto_app/profile/domain/respositories/profile_repository.dart';
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

  //HOME
  locator.registerSingleton<HomeApiService>(
    HomeApiService(locator<Dio>()),
  );

  locator.registerSingleton<FirebaseHomeServices>(
    FirebaseHomeServices(),
  );

  locator.registerSingleton<HomeApiRepository>(
    HomeRepositoryImpl(locator<HomeApiService>(), locator<FirebaseHomeServices>()),
  );

  //FAVORITES
  locator.registerSingleton<FavoriteApiService>(
    FavoriteApiService(locator<Dio>()),
  );

  locator.registerSingleton<FirebaseFavoriteServices>(
    FirebaseFavoriteServices(),
  );

  locator.registerSingleton<FavoriteApiRepository>(
    FavoriteRepositoryImpl(locator<FavoriteApiService>(), locator<FirebaseFavoriteServices>()),
  );

  //LOGIN
  locator.registerSingleton<ProfileApiService>(
    ProfileApiService(locator<Dio>()),
  );

  locator.registerSingleton<FirebaseProfileService>(
    FirebaseProfileService(),
  );

  locator.registerSingleton<ProfileApiRepository>(
    ProfileRepositoryImpl(locator<FirebaseProfileService>()),
  );
}
