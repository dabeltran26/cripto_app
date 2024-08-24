import 'package:cripto_app/config/colors.dart';
import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  const Loading({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(
          color: ColorsApp.primaryColor,
        ),
      ),
    );
  }
}
