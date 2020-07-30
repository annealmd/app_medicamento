import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

import '../providers/medicamentos.dart';
import '../screens/medicamento_detail_screen.dart';

class MedicamentoAlarme extends StatelessWidget {
  

  List<Widget> _alarmes(int frequencia, DateTime inicio) {
    List<Widget> alarme = [];
    int hours = frequencia;    
    for (var i = 0; i < 24; i+= hours) {
      //i += (hours - 1.0); 
      alarme.add(
        Text(
          DateFormat(DateFormat.HOUR24_MINUTE, 'pt_Br')
              .format(inicio.add(Duration(hours: i))),
          style: TextStyle( fontSize: 14),
        ),        
      );
      alarme.add(SizedBox(width: 6,),);
    }
    return alarme;
  }

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting('pt_BR', null);
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      child: FutureBuilder(
        future: Provider.of<Medicamentos>(context, listen: false)
            .fetchAndSetMedicamento(),
        builder: (ctx, snapshot) => snapshot.connectionState ==
                ConnectionState.waiting
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Consumer<Medicamentos>(
                child: Center(
                  child: const Text(
                    'Nenhum Alarme!',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                builder: (context, medicamentos, child) =>
                    medicamentos.items.length <= 0
                        ? child
                        : ListView.builder(
                            itemBuilder: (ctx, i) => Column(
                              children: <Widget>[
                                GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).pushNamed(
                                        MedicamentoDetailScreen.routeName,
                                        arguments: medicamentos.items[i].id);
                                  },
                                  child: Card(
                                    elevation: 5,
                                    child: ListTile(
                                      leading: CircleAvatar(
                                        backgroundColor: Medicamentos.avatarCor(
                                            medicamentos.items[i].id),
                                        radius: 30,
                                        child: Padding(
                                          padding: EdgeInsets.all(6),
                                          child: FittedBox(
                                              child: Text(
                                                  '${medicamentos.items[i].id}',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold))),
                                        ),
                                      ),
                                      title: Text(medicamentos.items[i].title),
                                      subtitle:  Wrap(
                                              children: _alarmes(
                                              medicamentos.items[i].frequencia,
                                              medicamentos.items[i].horaInicio),
                                      ),        
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            itemCount: medicamentos.items.length,
                          ),
              ),
      ),
    );
  }
}
