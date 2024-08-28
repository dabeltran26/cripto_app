import 'package:cripto_app/login/presentation/views/login_view.dart';
import 'package:flutter/material.dart';
import 'package:integration_test/integration_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cripto_app/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Inicio de Sesión', () {
    testWidgets('Verifica campos y botón de inicio de sesión', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();
      /*await tester.pumpWidget(const MaterialApp(
        home: LoginView(),
      ));*/
      final emailField = find.byKey(const ValueKey('email_field'));
      final passwordField = find.byKey(const ValueKey('password_field'));
      final loginButton =
      find.byWidgetPredicate((widget) => widget is ElevatedButton && widget.key == const Key('login_button'));

      await tester.enterText(emailField, 'david@mail.com');
      await tester.enterText(passwordField, '12345678');

      await tester.tap(loginButton);
      await tester.pumpAndSettle();

      // Verificar siguiente pantalla
    });
  });
}
