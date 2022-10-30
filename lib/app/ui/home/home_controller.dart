import 'package:flutter/cupertino.dart';

class HomeController extends ChangeNotifier {
  final double taxaDesconto;
  double valorDesconto;
  double valorAPagar;

  HomeController({this.taxaDesconto = 0.15, this.valorDesconto = 0.0, this.valorAPagar = 0.0});

  void calcularDescontoParcela(double valorParcela) {
    valorDesconto = valorParcela * taxaDesconto;
    valorAPagar = valorParcela - valorDesconto;

    notifyListeners();
  }
}
