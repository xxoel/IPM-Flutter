import 'package:flutter/material.dart';
import 'package:integration_test/integration_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:app_movil/main.dart' as app;

void main(){
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  group('Tests de Busqueda', () {
    testWidgets(
        'Ventana de busqueda erronea bien hecha', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();
      await tester.enterText(find.byType(TextField), 'jajajajaja');
      await tester.tap(find.byIcon(Icons.search));
      await tester.pumpAndSettle();
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pumpAndSettle(const Duration(seconds: 3));
      expect(find.text('Su palabra no está relacionada con ninguna receta :('),
          findsOneWidget);
    });
    testWidgets(
        'Ventana de busqueda correcta bien hecha', (WidgetTester tester) async {
      const infoDetallada = Key('Tomato Gravy');
      app.main();
      await tester.pumpAndSettle();
      await tester.enterText(find.byType(TextField), 'tomato');
      await tester.tap(find.byIcon(Icons.search));
      await tester.pumpAndSettle();
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pumpAndSettle(const Duration(seconds: 2));
      expect(find.byType(Ink), findsAtLeastNWidgets(20));

      await tester.tap(find.byKey(infoDetallada));
      await tester.pumpAndSettle(const Duration(seconds: 2));
      expect(find.byType(ListView), findsOneWidget);
      expect(find.byType(Container), findsAtLeastNWidgets(7));
    });
    testWidgets('Test de busqueda vacia', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();
      await tester.tap(find.byIcon(Icons.search));
      await tester.pumpAndSettle(const Duration(seconds: 1));
      expect(find.text('EL CAMPO NO PUEDE ESTAR VACIO'),findsOneWidget);
    });
  });
  group('Tests de Ventana Ajustes y Ayuda', () {
    testWidgets('Test de Ventana Ajustes', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();
      await tester.tap(find.byIcon(Icons.settings));
      await tester.pumpAndSettle(const Duration(seconds: 1));
      expect(find.text('Bienvenido a la pestaña de Opciones'), findsOneWidget);
      expect(find.byType(Image),findsOneWidget);
      expect(find.byType(ElevatedButton),findsAtLeastNWidgets(3));
    });
    testWidgets('Test de Ventana Ayuda', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();
      await tester.tap(find.byIcon(Icons.help));
      await tester.pumpAndSettle(const Duration(seconds: 1));
      expect(find.text('En esta pestaña se mostrará como usar la aplicación de búsqueda de recetas.'
          'Deberás introducir la palabra clave sobre la cual deseas obtener recetas que la contengan '
          'en la barra de búsqueda, y una vez hecho esto, presionar la tecla ENTER. '
          'El sistema se encargará de mostrarte las recetas que contienen esa palabra clave, o el error '
          'correspondiente. !Muchas gracias por usar nuestra aplicación!'), findsOneWidget);
      expect(find.byType(ElevatedButton), findsOneWidget);
    });
  });
  group('Tests de error de red', () {
    testWidgets('Test de error de Red', (WidgetTester tester) async{
      app.main();
      await tester.pumpAndSettle();
      await tester.pumpAndSettle(const Duration(seconds: 10));
      expect(find.text('Error de red: No se ha podido establecer la conexión a internet.'
          ' Compruebe su conexión a la red o inténtelo de nuevo más tarde.'), findsOneWidget);
    });
  });
}