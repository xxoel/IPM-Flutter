import 'package:flutter/material.dart';
import 'package:integration_test/integration_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:app_movil/main.dart' as app;

void main(){
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  testWidgets('Ventana de busqueda erronea bien hecha',(WidgetTester tester) async {

    const testKey = Key('K');
    const ventanaMalKey = Key('L');

    app.main();
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField), 'jajajajaja');
    await tester.tap(find.byKey(testKey));
    await tester.pumpAndSettle();
    await tester.testTextInput.receiveAction(TextInputAction.done);
    await tester.pumpAndSettle();

    expect(find.byKey(ventanaMalKey),findsOneWidget);
  });
}