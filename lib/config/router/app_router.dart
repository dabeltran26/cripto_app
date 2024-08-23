import 'package:auto_route/auto_route.dart';
import 'package:cripto_app/init.dart';
import 'package:cripto_app/login/presentation/views/login_view.dart';
import 'package:flutter/material.dart';

part 'app_router.gr.dart';

@AdaptiveAutoRouter(
  routes: [
    AutoRoute(page: InitView, initial: true),
    AutoRoute(page: LoginView),
  ],
)
class AppRouter extends _$AppRouter {}

final appRouter = AppRouter();
