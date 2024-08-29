import 'package:cripto_app/utils/responsive.dart';
import 'package:flutter/material.dart';

class TestWidget extends StatelessWidget {
  final Widget item;

  const TestWidget({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    MediaQueryData size = MediaQuery.of(context);
    ResponsiveUtil.setScreenSize(size);
    return item;
  }
}
