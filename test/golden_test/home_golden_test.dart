import 'package:cripto_app/home/data/datasource/home_service.dart';
import 'package:cripto_app/home/presentation/cubit/home_cubit.dart';
import 'package:cripto_app/home/presentation/views/home_view.dart';
import 'package:cripto_app/resources/models/coin_model.dart';
import 'package:cripto_app/test_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';

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
      ]);
}

class MockHomeService extends Mock implements HomeApiService {}

void main() {
  final getIt = GetIt.instance;
  late MockHomeCubit mockHomeCubit;

  setUpAll(() {
    mockHomeCubit = MockHomeCubit();
    getIt.registerSingleton<MockHomeService>(MockHomeService());
    getIt.registerSingleton<HomeCubit>(mockHomeCubit);
  });

  setUp(() {});

  tearDown(() {
    getIt.reset();
  });

  testWidgets('golden home', (tester) async {
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

    expectLater(
      find.byType(HomeView),
      matchesGoldenFile(
        'images/home.png',
      ),
    );
  });
}
