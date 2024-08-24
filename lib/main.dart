import 'package:cripto_app/config/app_theme.dart';
import 'package:cripto_app/config/locator.dart';
import 'package:cripto_app/config/providers.dart';
import 'package:cripto_app/config/router/app_router.dart';
import 'package:cripto_app/resources/api_client.dart';
import 'package:cripto_app/resources/hive_service.dart';
import 'package:cripto_app/resources/json_reader.dart';
import 'package:cripto_app/utils/strings.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/date_symbol_data_local.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await HiveService.initHive();
  await JsonReader.initialize();
  await initializeDependencies();
  ApiClient().setHeader();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting('es');
    return MultiBlocProvider(
      providers: Providers.getProviders(),
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerDelegate: appRouter.delegate(),
        routeInformationParser: appRouter.defaultRouteParser(),
        title: appTitle,
        theme: AppTheme.getTheme(),
      ),
    );
  }
}
