import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import './user_medicamento_screen.dart';

class AboutMe extends StatefulWidget {
  static const routeName = '/about';

  @override
  _AboutMeState createState() => _AboutMeState();
}

class _AboutMeState extends State<AboutMe> {
  Future<void> _launchInApp() async {
    const url = 'https://apoia.se/agenda_medicamentos';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Não foi possível abrir $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage( 'assets/images/star_background.png'),
            fit: BoxFit.cover),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: const Text('Anne Almeida'),
          backgroundColor: Colors.pink[300],
          leading: IconButton(
              icon: Icon(Icons.home),
              onPressed: () {
                Navigator.of(context).pop();
              }),
        ),
        body: Center(
          child: Container(
            child: Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: 30, bottom: 10),
                  width: MediaQuery.of(context).size.width * 0.95,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    elevation: 10,
                    child: Column(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(top: 20, bottom: 1),
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 50,
                            child: ClipOval(
                              child: Image.asset(
                                'assets/images/eu.jpg',
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            children: <Widget>[
                              Text(
                                'Comecei na Computação depois dos 40 anos. O meu objetivo é desenvolver produtos que tenham um impacto positivo na sociedade e proporcione uma vida melhor para todos. ',
                                textAlign: TextAlign.justify,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 17.0,
                                    height: 1.5,
                                    color: Colors.grey[900]),
                                maxLines: 5,
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Text(
                                'Caso esse aplicativo seja útil para você, considere fazer uma contribuição financeira para que eu possa continuar a minha Missão.',
                                textAlign: TextAlign.justify,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 17.0,
                                    height: 1.5,
                                    color: Colors.grey[900]),
                                maxLines: 5,
                              ),
                              SizedBox(
                                height: 8,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: RaisedButton.icon(
                    elevation: 5,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                    color: Colors.pink[300],
                    onPressed: () {
                      Navigator.of(context).pop(false);
                      setState(() {
                        _launchInApp();
                      });
                    },
                    icon: Icon(
                      Icons.mood,
                      color: Colors.pink[800],
                    ),
                    label: Text(
                      'Contribua Aqui!',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
