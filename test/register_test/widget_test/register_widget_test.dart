import 'package:cripto_app/register/data/datasource/register_service.dart';
import 'package:cripto_app/register/presentation/cubit/register_cubit.dart';
import 'package:cripto_app/register/presentation/views/register_view.dart';
import 'package:cripto_app/test_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';

class MockRegisterCubit extends MockCubit<RegisterState> implements RegisterCubit {
  @override
  RegisterState get state => const RegisterInitial('');
}

class MockRegisterService extends Mock implements RegisterApiService {}

void main() {
  final getIt = GetIt.instance;
  late MockRegisterCubit mockRegisterCubit;

  setUpAll(() {
    mockRegisterCubit = MockRegisterCubit();
    getIt.registerSingleton<MockRegisterService>(MockRegisterService());
    getIt.registerSingleton<RegisterCubit>(mockRegisterCubit);
  });

  setUp(() {});

  tearDown(() {
    getIt.reset();
  });

  testWidgets('register', (tester) async {
    await tester.pumpWidget(
      TestWidget(
        item: MaterialApp(
          home: BlocProvider<RegisterCubit>.value(
            value: mockRegisterCubit,
            child: const RegisterView(),
          ),
        ),
      ),
    );

    final nameTextField = find.byKey(const ValueKey('name_field'));
    final emailTextField = find.byKey(const ValueKey('email_field'));
    final passwordTextField = find.byKey(const ValueKey('password_field'));
    final birthDateTextField = find.byKey(const ValueKey('birth_date_field'));
    final checkBox = find.byKey(const ValueKey('check_box'));
    final createAccountGesture = find.byKey(const ValueKey('create_account_gesture'));

    expect(nameTextField, findsOneWidget);
    expect(emailTextField, findsOneWidget);
    expect(passwordTextField, findsOneWidget);
    expect(birthDateTextField, findsOneWidget);
    expect(checkBox, findsOneWidget);
    expect(createAccountGesture, findsOneWidget);

    await tester.enterText(nameTextField, 'david beltran');
    await tester.enterText(emailTextField, 'david@mail.com');
    await tester.enterText(passwordTextField, '12345678');

    await tester.tap(birthDateTextField);
    await tester.pumpAndSettle();

    final datePicker = find.byType(DatePickerDialog);
    expect(datePicker, findsOneWidget);
  });
}
