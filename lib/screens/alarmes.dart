import 'package:flutter/material.dart';

import 'package:medicamento/widgets/medicamento_alarmes.dart';

class Alarmes extends StatelessWidget {
  static const routeName = '/alarmes';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Horário das Notificações'),
        backgroundColor: Colors.indigo[700],
        leading: IconButton(
            icon: Icon(Icons.home),
            onPressed: () {
              Navigator.of(context).popAndPushNamed('/user-medicamentos');
            }),
      ),
      body: MedicamentoAlarme(),
    );
  }
}
