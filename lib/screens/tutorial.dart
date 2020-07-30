import 'package:flutter/material.dart';

import './user_medicamento_screen.dart';

class Tutorial extends StatelessWidget {
  static const routeName = '/tutorial';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tutorial'),
        leading: IconButton(
            icon: Icon(Icons.home),
            onPressed: () {
              Navigator.of(context).pop('/user-medicamentos');  
            }),
      ),
    );
  }
}
