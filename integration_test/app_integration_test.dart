import 'package:bloc_test/bloc_test.dart';
import 'package:cripto_app/home/data/datasource/home_service.dart';
import 'package:cripto_app/home/presentation/cubit/home_cubit.dart';
import 'package:cripto_app/home/presentation/views/home_view.dart';
import 'package:cripto_app/login/data/datasource/firebase_login_service.dart';
import 'package:cripto_app/login/data/datasource/login_service.dart';
import 'package:cripto_app/login/presentation/cubit/login_cubit.dart';
import 'package:cripto_app/login/presentation/views/login_view.dart';
import 'package:cripto_app/resources/models/coin_model.dart';
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

class MockHomeCubit extends MockCubit<HomeState> implements HomeCubit {
  @override
  HomeState get state => HomeSuccess([
        CoinModel(
            name: 'Bitcoin',
            symbol: 'BTC',
            image: 'https://assets.coingecko.com/coins/images/1/large/bitcoin.png?1696501400',
            currentPrice: 0,
            priceChangePercentage24H: 0),
        CoinModel(
            name: 'Ethereum',
            symbol: 'ETH',
            image: 'https://assets.coingecko.com/coins/images/1/large/bitcoin.png?1696501400',
            currentPrice: 0,
            priceChangePercentage24H: 0),
        CoinModel(
            name: 'Dog',
            symbol: 'DOG',
            image: 'https://assets.coingecko.com/coins/images/1/large/bitcoin.png?1696501400',
            currentPrice: 0,
            priceChangePercentage24H: 0),
        CoinModel(
            name: 'CriptoPeso',
            symbol: 'CPO',
            image: 'https://assets.coingecko.com/coins/images/1/large/bitcoin.png?1696501400',
            currentPrice: 0,
            priceChangePercentage24H: 0),
      ]);
}

class MockHomeService extends Mock implements HomeApiService {}

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  final getIt = GetIt.instance;
  late MockLoginCubit mockLoginCubit;
  late MockHomeCubit mockHomeCubit;

  setUpAll(() {
    mockLoginCubit = MockLoginCubit();
    mockHomeCubit = MockHomeCubit();
    getIt.registerSingleton<MockLoginService>(MockLoginService());
    getIt.registerSingleton<MockFirebaseLoginService>(MockFirebaseLoginService());
    getIt.registerSingleton<LoginCubit>(mockLoginCubit);
    getIt.registerSingleton<HomeCubit>(mockHomeCubit);
  });

  setUp(() {});

  tearDown(() {
    getIt.reset();
  });

  group('app', () {
    testWidgets('flujo app', (WidgetTester tester) async {
      app.main();
      await tester.pumpWidget(
        TestWidget(
          item: MaterialApp(
            home: MultiBlocProvider(
              providers: [
                BlocProvider<LoginCubit>.value(value: mockLoginCubit),
                BlocProvider<HomeCubit>.value(value: mockHomeCubit),
              ],
              child: const LoginView(),
            ),
          ),
        ),
      );

      final emailTextField = find.byKey(const ValueKey('email_field'));
      final passwordTextField = find.byKey(const ValueKey('password_field'));
      final loginButton = find.byKey(const ValueKey('login_button'));
      final gestureDetectorLogin = find.byKey(const Key('login_gesture'));

      expect(emailTextField, findsOneWidget);
      expect(passwordTextField, findsOneWidget);
      expect(loginButton, findsOneWidget);
      expect(gestureDetectorLogin, findsOneWidget);

      await tester.enterText(emailTextField, 'david@mail.com');
      await tester.enterText(passwordTextField, '12345678');
      await tester.pump();

      await tester.pumpWidget(
        TestWidget(
          item: MaterialApp(
            home: BlocProvider<HomeCubit>.value(
              value: mockHomeCubit,
              child: const HomeView(),
            ),
          ),
        ),
      );
      final titleText = find.byKey(const ValueKey('title_text'));
      final searchBarTextField = find.byKey(const ValueKey('search_bar'));
      final sliderCoins = find.byKey(const ValueKey('slider_coins'));

      expect(titleText, findsOneWidget);
      expect(searchBarTextField, findsOneWidget);
      expect(sliderCoins, findsOneWidget);

      await tester.drag(sliderCoins, const Offset(0, 2));
      await tester.pump();

      await tester.enterText(searchBarTextField, 'Bitcoin');
      await tester.pump();
      expect(find.byKey(const ValueKey('Bitcoin_coin')), findsOneWidget);
    });
  });
}
