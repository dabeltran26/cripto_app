import 'package:cripto_app/config/lcoator.dart';
import 'package:cripto_app/login/domain/respositories/login_repository.dart';
import 'package:cripto_app/login/presentation/cubit/login_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/single_child_widget.dart';

abstract class Providers {
  static List<SingleChildWidget> getProviders() {
    List<SingleChildWidget> providers = [
      BlocProvider(
          create: (context) => LoginCubit(
                locator<LoginApiRepository>(),
              )),
    ];
    return providers;
  }
}
