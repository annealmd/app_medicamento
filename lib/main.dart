import 'package:flutter/material.dart';
import 'package:medicamento/screens/medicamento_detail_screen.dart';

import 'package:provider/provider.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import './screens/welcome_screen.dart';
import './screens/user_medicamento_screen.dart';
import './providers/medicamentos.dart';
import './screens/medicamento_editar_screen.dart';
import './screens/medicamento_add_screen.dart';
import './screens/aboutMe.dart';
import './screens/alarmes.dart';
import './screens/tutorial.dart';

void main() => runApp(Medicamento());

class Medicamento extends StatelessWidget {
  const Medicamento({Key key}) : super(key: key);
  

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      //ChangeNotifierProvider p 1 instancia
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => Medicamentos(), // instancias
        ),
      ],
      child: MaterialApp(
        title: 'Medicamento',
        theme: ThemeData(
          primarySwatch: Colors.teal,
          accentColor: Colors.pink[600],
          fontFamily: 'Lato',
        ),
        //home: auth.isAuth ? UserMedicamentossScreen() : AuthScreen(),
        home: WelcomeScreen(),
        routes: {
          UserMedicamentosScreen.routeName: (context) =>
              UserMedicamentosScreen(),
          MedicamentoDetailScreen.routeName: (context) =>
              MedicamentoDetailScreen(),
          MedicamentoEditarScreen.routeName: (context) =>
              MedicamentoEditarScreen(),
          MedicamentoAddScreen.routeName: (context) => MedicamentoAddScreen(),
          Tutorial.routeName: (context) => Tutorial(),
          Alarmes.routeName: (context) => Alarmes(),
          AboutMe.routeName: (context) => AboutMe(),
        },
      ),
    );
  }
}
