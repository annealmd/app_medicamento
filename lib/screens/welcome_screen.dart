import 'package:flutter/material.dart';

import './user_medicamento_screen.dart';

class WelcomeScreen extends StatelessWidget {
  static const routeName = '/welcome';

  const WelcomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    stops: [
                  0.1,
                  0.4,
                  0.6,
                  0.9
                ],
                    colors: [
                  Colors.white,
                  Colors.white,
                  Colors.white,
                  Colors.grey[50]
                ])),
          ),
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              color: Colors.blueGrey[400],
              elevation: 25,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 50, bottom: 20),
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 80,
                      child: Image.asset(
                        'assets/images/pills.png',
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    child: const ListTile(
                      title: Text('Bem-Vindo',
                          style: TextStyle(color: Colors.white, fontSize: 40)),
                      subtitle: Text('Agenda de Medicamentos',
                          style: TextStyle(color: Colors.white)),
                    ),
                  ),
                  Divider(),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 30),
                    width: 200,
                    child: RaisedButton.icon(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                      onPressed: () {
                        Navigator.of(context)
                            .pushReplacementNamed(UserMedicamentosScreen.routeName);
                      },
                      icon: Icon(Icons.flare),
                      label: Text(
                        'Entrar',
                        style: TextStyle(fontSize: 20),
                      ),
                      color: Colors.white,
                      elevation: 5,
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  )
                ],
              ),
            ),
          ),
          // Container(
          //   alignment: Alignment.center,
          //   child: Card(

          //     shape: RoundedRectangleBorder(
          //       borderRadius: BorderRadius.circular(15.0),
          //     ),
          //     elevation: 10,
          //     child: Column(
          //       mainAxisAlignment: MainAxisAlignment.center,
          //       crossAxisAlignment: CrossAxisAlignment.center,
          //       children: <Widget>[
          //         Text(
          //           'Hello Medicamento',
          //           style: TextStyle(fontWeight: FontWeight.bold),
          //           textAlign: TextAlign.center,
          //         ),
          //         Divider(),
          //         FlatButton.icon(
          //           onPressed: () {
          //             Navigator.of(context)
          //                 .pushNamed(UserMedicamentosScreen.routeName);
          //           },
          //           icon: Icon(Icons.flare),
          //           label: Text('Entrar'),
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
