import 'package:bloc_test/bloc_test.dart';
import 'package:cripto_app/home/presentation/cubit/home_cubit.dart';
import 'package:cripto_app/resources/base_state.dart';
import 'package:cripto_app/resources/models/coin_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'mock_home_repository.mocks.dart';

void main() {
  group('home coins test', () {
    late HomeCubit homeCubit;
    late MockHomeApiRepository mockApiRepository;

    setUp(() {
      mockApiRepository = MockHomeApiRepository();
      homeCubit = HomeCubit(mockApiRepository);
    });

    tearDown(() {
      homeCubit.close();
    });

    blocTest<HomeCubit, HomeState>(
      'verificar trare coins melo',
      build: () {
        when(mockApiRepository.getCoins()).thenAnswer((_) async => DataSuccess<List<CoinModel>>([
              CoinModel(name: 'Bitcoin', symbol: 'BTC'),
              CoinModel(name: 'Ethereum', symbol: 'ETH'),
            ]));
        return homeCubit;
      },
      act: (cubit) => cubit.getCoins(),
      expect: () => [
        const HomeLoading(),
        isA<HomeSuccess>().having((state) => state.coins.length, 'coins length', 2),
      ],
    );

    blocTest<HomeCubit, HomeState>(
      'verificar traer coins fale',
      build: () {
        final dioError = DioException(
          requestOptions: RequestOptions(path: ''),
          error: 'Error al obtener datos.',
          type: DioExceptionType.unknown,
        );
        when(mockApiRepository.getCoins()).thenAnswer((_) async => DataFailed(dioError));
        return homeCubit;
      },
      act: (cubit) => cubit.getCoins(),
      expect: () => [
        const HomeLoading(),
        const HomeFailed('Hubo un error inesperado.'),
      ],
    );
  });
}
