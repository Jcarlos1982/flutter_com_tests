import 'package:examplo_testes/app/ui/comprovantes/comprovantes.dart';
import 'package:examplo_testes/app/ui/home/home_controller.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  final String title;

  const HomePage({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var valorParcela = TextEditingController();

    //Recuperando a instância do HomeController
    final homeController = HomeController();

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const Icon(
              Icons.check_circle_outline_outlined,
              color: Colors.green,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(title),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Exemplo de Testes'),
              const SizedBox(
                height: 30,
              ),
              AnimatedBuilder(
                animation: homeController,
                builder: (context, child) {
                  return Text(
                    key: const Key('valorAPagar'),
                    'Valor a pagar: R\$ ${homeController.valorAPagar}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  );
                },
              ),
              const SizedBox(
                height: 30,
              ),
              FractionallySizedBox(
                widthFactor: 0.7,
                child: TextField(
                  key: const Key('valorParcela'),
                  controller: valorParcela,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(border: OutlineInputBorder(), label: Text('Informe o valor da parcela')),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  key: const Key('botaoCalcularDesconto'),
                  onPressed: () {
                    double valor = double.parse(valorParcela.text);
                    homeController.calcularDescontoParcela(valor);
                  },
                  child: const Text('Calcular Desconto')),
              const SizedBox(height: 10),
              ElevatedButton(
                  key: const Key('botaoVerComprovantes'),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const ComprovantePage()));
                  },
                  child: const Text('Ver comprovantes'))
            ],
          ),
        ),
      ),
    );
  }
}
