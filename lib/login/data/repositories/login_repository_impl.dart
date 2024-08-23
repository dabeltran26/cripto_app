import 'package:cripto_app/login/data/datasource/login_service.dart';
import 'package:cripto_app/login/domain/respositories/login_repository.dart';
import 'package:cripto_app/resources/base_api_repository.dart';
import 'package:cripto_app/resources/base_state.dart';

class LoginRepositoryImpl extends BaseApiRepository implements LoginApiRepository {
  final LoginApiService _apiService;

  LoginRepositoryImpl(this._apiService);

  @override
  Future<DataState<dynamic>> login() {
    return getStateOf<dynamic>(
      request: () => _apiService.login(),
    );
  }
}
