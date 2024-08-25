import 'package:cripto_app/config/locator.dart';
import 'package:cripto_app/favorites/domain/respositories/favorite_repository.dart';
import 'package:cripto_app/favorites/presentation/cubit/favorite_cubit.dart';
import 'package:cripto_app/home/domain/respositories/home_repository.dart';
import 'package:cripto_app/home/presentation/cubit/home_cubit.dart';
import 'package:cripto_app/login/domain/respositories/login_repository.dart';
import 'package:cripto_app/login/presentation/cubit/login_cubit.dart';
import 'package:cripto_app/profile/domain/respositories/profile_repository.dart';
import 'package:cripto_app/profile/presentation/cubit/profile_cubit.dart';
import 'package:cripto_app/register/domain/repositories/register_repository.dart';
import 'package:cripto_app/register/presentation/cubit/register_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/single_child_widget.dart';

abstract class Providers {
  static List<SingleChildWidget> getProviders() {
    List<SingleChildWidget> providers = [
      BlocProvider(
          create: (context) => LoginCubit(
                locator<LoginApiRepository>(),
              )),
      BlocProvider(
          create: (context) => RegisterCubit(
                locator<RegisterApiRepository>(),
              )),
      BlocProvider(
          create: (context) => HomeCubit(
                locator<HomeApiRepository>(),
              )..getCoins()),
      BlocProvider(
          create: (context) => FavoriteCubit(
                locator<FavoriteApiRepository>(),
              )),
      BlocProvider(
          create: (context) => ProfileCubit(
                locator<ProfileApiRepository>(),
              )..getUser()),
    ];
    return providers;
  }
}
