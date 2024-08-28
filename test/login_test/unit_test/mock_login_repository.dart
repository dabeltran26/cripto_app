import 'package:cripto_app/login/domain/respositories/login_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:bloc_test/bloc_test.dart';

@GenerateMocks([LoginApiRepository])
import '../../../integration_test/app_test.dart';