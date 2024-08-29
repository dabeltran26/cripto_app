import 'package:bloc_test/bloc_test.dart';
import 'package:cripto_app/login/data/datasource/login_service.dart';
import 'package:cripto_app/login/presentation/cubit/login_cubit.dart';
import 'package:cripto_app/login/presentation/views/login_view.dart';
import 'package:cripto_app/test_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_test/flutter_test.dart';
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

  testWidgets('login', (tester) async {
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
    final emailTextField = find.byKey(const ValueKey('email_field'));
    final passwordTextField = find.byKey(const ValueKey('password_field'));
    final loginButton = find.byKey(const ValueKey('login_button'));
    final gestureDetectorLogin = find.byKey(const Key('login_gesture'));
    final gestureDetectorGoRegister = find.byKey(const Key('go_register_gesture'));

    expect(emailTextField, findsOneWidget);
    expect(passwordTextField, findsOneWidget);
    expect(loginButton, findsOneWidget);
    expect(gestureDetectorLogin, findsOneWidget);
    expect(gestureDetectorGoRegister, findsOneWidget);

    await tester.enterText(emailTextField, 'david@mail.com');
    await tester.enterText(passwordTextField, '12345678');
  });
}
