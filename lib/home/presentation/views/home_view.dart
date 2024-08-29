import 'package:cripto_app/config/colors.dart';
import 'package:cripto_app/home/presentation/cubit/home_cubit.dart';
import 'package:cripto_app/home/presentation/widgets/item_coin.dart';
import 'package:cripto_app/utils/responsive.dart';
import 'package:cripto_app/utils/strings.dart';
import 'package:cripto_app/widgets/custom_textfield.dart';
import 'package:cripto_app/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late HomeCubit homeCubit;
  TextEditingController? searchController;
  String searchText = '';

  @override
  void initState() {
    homeCubit = BlocProvider.of<HomeCubit>(context);
    searchController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorsApp.black5,
        body: Builder(
          builder: (context) => BlocBuilder<HomeCubit, HomeState>(builder: (_, state) {
            switch (state.runtimeType) {
              case HomeSuccess:
                return Column(
                  children: [
                    const Text(
                      key: Key('title_text'),
                      appTitle,
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Padding(
                      padding: EdgeInsets.only(left: 4.w, right: 4.w),
                      child: CustomTextField(
                        key: const Key('search_bar'),
                        'Buscar criptomoneda...',
                        searchController,
                        borderColor: ColorsApp.primaryColor,
                        onChange: (value) {
                          homeCubit.searchCoins(value, () {
                            setState(() {});
                          });
                        },
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Expanded(
                      child: ListView.builder(
                        key: const Key('slider_coins'),
                        itemCount: state.coins!.length,
                        itemBuilder: (context, index) {
                          return ItemCard(
                            coin: state.coins![index],
                            saveFavorite: () {
                              homeCubit.saveFavoriteCoin(state.coins![index], () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Agregado a tus favoritos'),
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
              case HomeLoading:
                return const Loading();
              default:
                return const SizedBox();
            }
          }),
        ));
  }
}
