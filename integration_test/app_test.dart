import 'package:bloc_test/bloc_test.dart';
import 'package:cripto_app/login/data/datasource/firebase_login_service.dart';
import 'package:cripto_app/login/data/datasource/login_service.dart';
import 'package:cripto_app/login/presentation/cubit/login_cubit.dart';
import 'package:cripto_app/login/presentation/views/login_view.dart';
import 'package:cripto_app/test_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:integration_test/integration_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:cripto_app/main.dart' as app;

class MockLoginCubit extends MockCubit<LoginState> implements LoginCubit {
  @override
  LoginState get state => const LoginInitial('');
}

class MockLoginService extends Mock implements LoginApiService {}

class MockFirebaseLoginService extends Mock implements FirebaseLoginService {}


void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  final getIt = GetIt.instance;
  late MockLoginCubit mockLoginCubit;

  setUpAll(() {
    mockLoginCubit = MockLoginCubit();
    getIt.registerSingleton<MockLoginService>(MockLoginService());
    getIt.registerSingleton<MockFirebaseLoginService>(MockFirebaseLoginService());
    getIt.registerSingleton<LoginCubit>(mockLoginCubit);
  });

  setUp(() {});

  tearDown(() {
    getIt.reset();
  });

  group('Inicio de Sesión', () {
    testWidgets('Verifica campos y botón de inicio de sesión', (WidgetTester tester) async {
      app.main();

      await tester.pumpWidget(
        TestWidget(
          item: MaterialApp(
            home: BlocProvider<LoginCubit>.value(
              value: mockLoginCubit,
              child: const LoginView(),
            ),
          ),
        ),
      );

      expect(find.byType(TextField), findsNWidgets(2));
    });
  });
}
