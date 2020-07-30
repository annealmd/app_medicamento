import 'package:flutter/material.dart';

import '../widgets/medicamento_list.dart';
import '../widgets/app_drawer.dart';
import './medicamento_add_screen.dart';

class UserMedicamentosScreen extends StatefulWidget {
  static const routeName = '/user-medicamentos';
  const UserMedicamentosScreen({Key key}) : super(key: key);

  @override
  _UserMedicamentosScreenState createState() => _UserMedicamentosScreenState();
}

class _UserMedicamentosScreenState extends State<UserMedicamentosScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meus Medicamentos'),
      ),
      drawer: AppDrawer(),
      body:MedicamentoList(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueGrey.shade800,
        onPressed: () {
          Navigator.of(context).pushNamed(MedicamentoAddScreen.routeName);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
