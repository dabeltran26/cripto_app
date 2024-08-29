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

  testWidgets('golden login', (tester) async {
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

    expectLater(
      find.byType(RegisterView),
      matchesGoldenFile(
        'images/register.png',
      ),
    );
  });
}
