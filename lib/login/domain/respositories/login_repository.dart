import 'package:cripto_app/resources/base_state.dart';

abstract class LoginApiRepository {
  Future<DataState<dynamic>> login();
}
