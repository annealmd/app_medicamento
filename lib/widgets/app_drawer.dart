import 'package:flutter/material.dart';
import 'package:medicamento/screens/alarmes.dart';
import 'package:medicamento/screens/tutorial.dart';

import '../screens/aboutMe.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.5,
      child: Drawer(
        child: Column(
          children: <Widget>[
            AppBar(
              title: Text('Importante'),
              backgroundColor: Colors.lightGreen[700],
              automaticallyImplyLeading: false, // not show back arrow
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.help),
              title: Text('Tutorial'),
              onTap: () {
                Navigator.of(context).pushNamed(Tutorial.routeName);
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.access_alarms),
              title: Text('Notificações'),
              onTap: () {
                Navigator.of(context).pushNamed(Alarmes.routeName);
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.mood),
              title: Text('SobreMim'),
              onTap: () {
                Navigator.of(context).pushNamed(AboutMe.routeName);
              },
            ),
            Divider(),
          ],
        ),
      ),
    );
  }
}
