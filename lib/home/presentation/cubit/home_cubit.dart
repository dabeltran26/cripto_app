import 'package:cripto_app/home/domain/respositories/home_repository.dart';
import 'package:cripto_app/resources/base_cubit.dart';
import 'package:cripto_app/resources/base_state.dart';
import 'package:cripto_app/resources/hive_service.dart';
import 'package:cripto_app/resources/models/coin_model.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

part 'package:cripto_app/home/presentation/cubit/home_state.dart';

class HomeCubit extends BaseCubit<HomeState> {
  final HomeApiRepository apiRepository;

  List<CoinModel> filterCoins = [];
  late List<CoinModel> allCoins;

  HomeCubit(this.apiRepository) : super(const HomeLoading());

  Future<void> getCoins() async {
    try {
      emit(const HomeLoading());
      var response = await apiRepository.getCoins();
      if (response is DataSuccess) {
        allCoins = response.data!;
        emit(HomeSuccess(allCoins));
      } else {
        emit(const HomeFailed('Hubo un error inesperado.'));
      }
    } catch (e) {
      emit(const HomeFailed('Hubo un error inesperado.'));
    }
  }

  void searchCoins(String searchText, Function refresh) {
    if (searchText.isEmpty) {
      filterCoins = allCoins;
      emit(HomeSuccess(filterCoins));
    } else {
      filterCoins = allCoins.where((crypto) => crypto.name.toLowerCase().contains(searchText.toLowerCase())).toList();
      emit(HomeSuccess(filterCoins));
    }
  }

  void saveFavoriteCoin(CoinModel coin, Function success) async {
    try {
      String uid = HiveService.getFirebaseToken();
      if (await apiRepository.saveFavorite(uid, coin)) {
        success();
      }
    } catch (e) {
      print(e);
    }
  }
}
