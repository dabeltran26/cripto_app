import 'package:cripto_app/home/presentation/views/home_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('golden home', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: HomeView(),
      ),
    );

    expectLater(
      find.byType(HomeView),
      matchesGoldenFile(
        'golden_test/images/home.png',
      ),
    );
  });
}
