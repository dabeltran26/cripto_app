import 'package:cripto_app/config/colors.dart';
import 'package:cripto_app/favorites/presentation/cubit/favorite_cubit.dart';
import 'package:cripto_app/favorites/presentation/widgets/item_favorite_coin.dart';
import 'package:cripto_app/utils/responsive.dart';
import 'package:cripto_app/utils/strings.dart';
import 'package:cripto_app/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoriteView extends StatefulWidget {
  const FavoriteView({super.key});

  @override
  State<FavoriteView> createState() => _FavoriteViewState();
}

class _FavoriteViewState extends State<FavoriteView> {
  late FavoriteCubit favoriteCubit;
  TextEditingController? searchController;
  String searchText = '';

  @override
  void initState() {
    favoriteCubit = BlocProvider.of<FavoriteCubit>(context);
    favoriteCubit.getFavoriteCoins();
    searchController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorsApp.black5,
        body: Builder(
          builder: (context) => BlocBuilder<FavoriteCubit, FavoriteState>(builder: (_, state) {
            switch (state.runtimeType) {
              case FavoriteSuccess:
                return Column(
                  children: [
                    const Text(
                      tittleFavorite,
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Expanded(
                      child: ListView.builder(
                        itemCount: state.coins!.length,
                        itemBuilder: (context, index) {
                          return ItemFavoriteCoin(
                            coin: state.coins![index],
                            saveFavorite: () {
                              favoriteCubit.deleteFavoriteCoin(state.coins![index], () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Eliminado de tus favoritos'),
                                    duration: Duration(seconds: 2),
                                  ),
                                );
                              });
                            },
                          );
                        },
                      ),
                    ),
                  ],
                );
              case FavoriteLoading:
                return const Loading();
              default:
                return const SizedBox();
            }
          }),
        ));
  }
}
