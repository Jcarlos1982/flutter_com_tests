import 'package:examplo_testes/app/ui/comprovantes/comprovantes.dart';
import 'package:examplo_testes/app/ui/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  // https://docs.flutter.dev/cookbook/testing/widget/introduction

  IntegrationTestWidgetsFlutterBinding.ensureInitialized;

  //Todo Widget precisa rodar a partir de um MaterialApp (ou CupertonoApp)
  MaterialApp buildTestableWidget(Key testkey, Widget widget) {
    return MaterialApp(key: testkey, home: widget);
  }

  group('Home - Testes de Widget(Componentes)', () {
    testWidgets('Deve renderizar todos os widogets', (tester) async {
      await tester.pumpWidget(buildTestableWidget(const Key('home'), const HomePage(title: 'Titulo')));

      //Verifica se renderizou os componentes corretamente

      final Finder titulo = find.byWidgetPredicate((widget) {
        if (widget is Text) {
          return widget.data == 'Informe o valor da parcela';
        }
        return false;
      });

      expect(titulo, findsOneWidget);

      expect(find.widgetWithIcon(AppBar, Icons.check_circle_outline_outlined), findsOneWidget);
      expect(find.text('Exemplo de Testes'), findsOneWidget);
      expect(find.text(r'Valor a pagar: R$ 0.0'), findsOneWidget);
      expect(find.widgetWithText(ElevatedButton, 'Calcular Desconto'), findsOneWidget);
      expect(find.widgetWithText(ElevatedButton, 'Ver comprovantes'), findsOneWidget);
    });

    testWidgets('Calcula um Desconto', (WidgetTester tester) async {
      await tester.pumpWidget(buildTestableWidget(const Key('home'), const HomePage(title: 'Titulo')));

      //Atribui o valor de 100 à parcela
      await tester.enterText(find.widgetWithText(TextField, 'Informe o valor da parcela'), '100');
      await tester.pumpAndSettle();

      //Pressiona o botão de calcular o desconto
      await tester.tap(find.byKey(const Key('botaoCalcularDesconto')));
      await tester.pumpAndSettle(const Duration(seconds: 5));

      final Text textAPagar = tester.widget(find.byKey(const Key('valorAPagar')));
      expect(textAPagar.data, r'Valor a pagar: R$ 85.0');
    });

    testWidgets('Exibe a tela de comprovantes', (WidgetTester tester) async {
      await tester.pumpWidget(buildTestableWidget(const Key('home'), const HomePage(title: 'Titulo')));

      //Encontra e Pressiona o botão de ver comprovantes
      await tester.tap(find.byKey(const Key('botaoVerComprovantes')));
      await tester.pumpAndSettle(const Duration(seconds: 5));

      //Recupera o novo estado dos widgets de interesse e verifica se este está correto
      final Finder comprovantes = find.byType(ComprovantePage);
      expect(comprovantes, findsOneWidget);

      expect(find.text('Comprovantes de pagamento'), findsOneWidget);
    });
  });
}
