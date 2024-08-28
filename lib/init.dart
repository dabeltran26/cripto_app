import 'package:cripto_app/base_view.dart';
import 'package:cripto_app/login/presentation/views/login_view.dart';
import 'package:cripto_app/resources/hive_service.dart';
import 'package:cripto_app/utils/responsive.dart';
import 'package:flutter/material.dart';

class InitView extends StatelessWidget {
  const InitView({super.key});

  @override
  Widget build(BuildContext context) {
    MediaQueryData size = MediaQuery.of(context);
    ResponsiveUtil.setScreenSize(size);
    String token = HiveService.getFirebaseToken();
    if (token != '') {
      return const BaseView();
    } else {
      return const LoginView();
    }
  }
}
