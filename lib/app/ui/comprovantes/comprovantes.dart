import 'package:flutter/material.dart';

class ComprovantePage extends StatelessWidget {
  const ComprovantePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Comprovantes de pagamento')),
      body: ListView.builder(
          itemCount: 50,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                title: Text('Comprovante de pagamento parcela nº $index'),
                trailing: const Icon(Icons.monetization_on),
              ),
            );
          }),
    );
  }
}
