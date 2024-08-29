import 'package:cripto_app/login/presentation/views/login_view.dart';
import 'package:cripto_app/test_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:cripto_app/login/data/datasource/login_service.dart';
import 'package:cripto_app/login/presentation/cubit/login_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';

class MockLoginCubit extends MockCubit<LoginState> implements LoginCubit {
  @override
  LoginState get state => const LoginInitial('');
}

class MockLoginService extends Mock implements LoginApiService {}

void main() {
  final getIt = GetIt.instance;
  late MockLoginCubit mockLoginCubit;

  setUpAll(() {
    mockLoginCubit = MockLoginCubit();
    getIt.registerSingleton<MockLoginService>(MockLoginService());
    getIt.registerSingleton<LoginCubit>(mockLoginCubit);
  });

  setUp(() {});

  tearDown(() {
    getIt.reset();
  });

  testWidgets('golden login', (tester) async {
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

    expectLater(
      find.byType(LoginView),
      matchesGoldenFile(
        'images/login.png',
      ),
    );
  });
}
