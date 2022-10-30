import 'package:examplo_testes/app/ui/home/home_controller.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  // https://docs.flutter.dev/cookbook/testing/unit/introduction

  late HomeController homeController;

  setUp(() {
    //Cria instancia do controller para possibilitar os testes de unidade
    homeController = HomeController();
  });

  group('HomeController Tests', () {
    test('Ao iniciar o valor da taxa de juros deve ser 15% e o valor', (() {
      expect(homeController.taxaDesconto, 0.15);
    }));

    test(r'Ao iniciar o valor do desconto deve ser R$ 0,00', (() {
      expect(homeController.valorDesconto, 0.0);
    }));

    test(r'O valor do desconto, após o cálculo, deve ser R$ 15,00.', (() {
      double valor = 100.0;
      homeController.calcularDescontoParcela(valor);

      expect(homeController.valorDesconto, 15.0);
    }));

    test(r'O valor da parcela, após o cálculo, deve ser R$ 85,00.', (() {
      double valor = 100.0;
      homeController.calcularDescontoParcela(valor);

      expect(homeController.valorAPagar, 85.0);

      //O método expect tem muitos matches predefinidos

      //https://api.flutter.dev/flutter/package-matcher_matcher/package-matcher_matcher-library.html#constants

      expect(homeController.valorAPagar, isA<double>());
      expect(homeController.valorAPagar, equals(85.00));
      expect(true, isTrue);
      expect(false, isFalse);
      expect('Sou um teste', isA<String>());
      expect('Sou um teste', contains('teste'));
    }));
  });
}
