import 'package:flutter/material.dart';
import 'package:medicamento/main.dart';
import 'package:medicamento/widgets/medicamento_alarmes.dart';
import 'package:provider/provider.dart';

import '../widgets/medicamento_list.dart';
import './user_medicamento_screen.dart';

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
              Navigator.of(context).pop('/user-medicamentos');  
            }),
      ),
      body:MedicamentoAlarme(),
    );
  }
}
