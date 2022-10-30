import 'package:examplo_testes/app/ui/comprovantes/comprovantes.dart';
import 'package:examplo_testes/app/ui/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  // https://docs.flutter.dev/cookbook/testing/widget/introduction

  //Todo Widget precisa rodar a partir de um MaterialApp (ou CupertonoApp)
  MaterialApp buildTestableWidget(Key testkey, Widget widget) {
    return MaterialApp(key: testkey, home: widget);
  }

  group('Home - Testes de Widget(Componentes)', () {
    testWidgets('O titulo da Home deve ser Titulo', (tester) async {
      await tester.pumpWidget(buildTestableWidget(const Key('home'), const HomePage(title: 'Titulo')));

      //Encontra um texto
      final titleFinder = find.text('Titulo');

      //Verifica se foi encontrado esse texto apenas uma vez
      expect(titleFinder, findsOneWidget);
    });

    testWidgets('Deve ter um ícone', (tester) async {
      //O método pumpWidget renderiza o widget que será testado
      await tester.pumpWidget(buildTestableWidget(const Key('home'), const HomePage(title: 'Titulo')));

      //Encontra um widget pelo tipo
      final Finder iconFinder = find.byType(Icon);
      expect(iconFinder, findsOneWidget);

      //Instancia o widget encontrado (caso precise testar alguma propriedade)
      final Icon icon = tester.widget(iconFinder);

      //Testando as propriedades do Icon
      expect(icon.icon, Icons.check_circle_outline_outlined);
      expect(icon.color, Colors.green);
    });

    testWidgets(r'Deve ter exibir: Valor a pagar: R$ 0.0', (tester) async {
      await tester.pumpWidget(buildTestableWidget(const Key('home'), const HomePage(title: 'Titulo')));

      final Finder textFinder = find.byKey(const Key('valorAPagar'));
      expect(textFinder, findsOneWidget);

      final Text textAPagar = tester.widget(textFinder);
      expect(textAPagar.data, r'Valor a pagar: R$ 0.0');
    });

    testWidgets('Calcula um Desconto', (WidgetTester tester) async {
      await tester.pumpWidget(buildTestableWidget(const Key('home'), const HomePage(title: 'Titulo')));

      //Encontra os widgets
      final valorParcela = find.byKey(const Key('valorParcela'));
      final botaoCalcularDesconto = find.byKey(const Key('botaoCalcularDesconto'));

      //Atribui o valor de 100 à parcela
      await tester.enterText(valorParcela, '100');

      //atualiza o estado dos componentes
      await tester.pumpAndSettle();

      //Pressiona o botão de calcular o desconto
      await tester.tap(botaoCalcularDesconto);
      await tester.pumpAndSettle(const Duration(seconds: 5));

      //Recupera o novo estado dos widgets de interesse e verifica se este está correto
      final Finder textFinder = find.byKey(const Key('valorAPagar'));
      expect(textFinder, findsOneWidget);

      final Text textAPagar = tester.widget(textFinder);
      expect(textAPagar.data, r'Valor a pagar: R$ 85.0');
    });

    testWidgets('Exibe a tela de comprovantes', (WidgetTester tester) async {
      await tester.pumpWidget(buildTestableWidget(const Key('home'), const HomePage(title: 'Titulo')));

      //Encontra e Pressiona o botão de ver comprovantes
      final botaoVerComprovantes = find.byKey(const Key('botaoVerComprovantes'));
      await tester.tap(botaoVerComprovantes);
      await tester.pumpAndSettle(const Duration(seconds: 5));

      //Recupera o novo estado dos widgets de interesse e verifica se este está correto
      final Finder comprovantes = find.byType(ComprovantePage);
      expect(comprovantes, findsOneWidget);

      expect(find.text('Comprovantes de pagamento'), findsOneWidget);
    });
  });
}
