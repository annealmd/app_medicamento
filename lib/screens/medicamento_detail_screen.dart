import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

import '../providers/medicamentos.dart';
import './medicamento_editar_screen.dart';

class MedicamentoDetailScreen extends StatelessWidget {
  static const routeName = '/medicamento-detail'; 

  @override
  Widget build(BuildContext context) {
    final medicamentoId =
        ModalRoute.of(context).settings.arguments as int; // recebe Id
    final loadedMedicamento = Provider.of<Medicamentos>(context, listen: false)
        .findById(medicamentoId);

    initializeDateFormatting('pt_BR', null);

    return Scaffold(
      appBar: AppBar(
        title: Text(loadedMedicamento.title),
        backgroundColor: Medicamentos.avatarCor(loadedMedicamento.id),
      ),
      body: Center(
        child: Container(
          width: double.infinity,
          margin: EdgeInsets.all(10),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            elevation: 10,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: 20, bottom: 20),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor:
                          Medicamentos.avatarCor(loadedMedicamento.id),
                      radius: 30,
                      child: Padding(
                        padding: EdgeInsets.all(6),
                        child: FittedBox(
                            child: Text(loadedMedicamento.id.toString(),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 50,
                                    fontWeight: FontWeight.bold))),
                      ),
                    ),
                    title: Text(
                      loadedMedicamento.title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    subtitle: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Text(
                              'Início:',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(width: 10),
                            Text(DateFormat('dd/MM/yyyy', 'pt_Br')
                                  .format(loadedMedicamento.dataInicio)),
                          ],
                        ),
                        loadedMedicamento.isContinuo ?
                             Row (
                                children: <Widget>[                             
                              Text(
                                'Final:',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              SizedBox(width: 10),
                              Text('* Uso Contínuo *'),
                            ],
                          )
                          : Row(
                            children: <Widget>[                             
                              Text(
                                'Final:',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              SizedBox(width: 10),
                              Text(
                                DateFormat('dd/MM/yyyy', 'pt_Br').format(
                                  loadedMedicamento.dataInicio.add(
                                    Duration(days: loadedMedicamento.duracao),
                                  ),
                                ),
                              ),
                            ],
                          ),
                      ],
                    ),
                  ),
                ),
                Divider(),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Quatidade:',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      Card(
                        elevation: 5,
                        color: Colors.amber[100],
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: Text(
                            loadedMedicamento.quantidade,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                        ),
                      ),
                      Text(
                        loadedMedicamento.dose,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 14),
                      ),
                    ],
                  ),
                ),
                Divider(),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Frequência:',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      Card(
                        elevation: 5,
                        color: Colors.amber[100],
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: Text(
                            loadedMedicamento.frequencia.toString(),
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                        ),
                      ),
                      Text(
                        'horas',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 14),
                      ),
                    ],
                  ),
                ),
                Divider(),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Duração:',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),                      
                      Card(
                        elevation: 5,
                        color: Colors.amber[100],
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: loadedMedicamento.isContinuo ?
                          Text(
                            'Uso Contínuo',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          )
                          :Text(
                            loadedMedicamento.duracao.toString(),
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                        ),
                      ),
                      Text(
                        'dias',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 14),
                      ),
                    ],
                  ),
                ),
                Divider(),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Horário que iniciou:',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      Card(
                        elevation: 5,
                        color: Colors.amber[100],
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: Text(
                            DateFormat(DateFormat.HOUR24_MINUTE, 'pt_Br')
                                  .format(loadedMedicamento.horaInicio),
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      RaisedButton.icon(
                        color: Colors.red[700],
                        onPressed: () {    
                          //Provider.of<Medicamentos>(context, listen: false).deleteAlarmes(loadedMedicamento.frequencia, loadedMedicamento.id);                      
                          Provider.of<Medicamentos>(context, listen: false).medicamentoDelete(loadedMedicamento.frequencia, loadedMedicamento.id);
                          Navigator.of(context).pop();                         
                        },
                        icon: Icon(Icons.delete),
                        label: Text(
                          'Apagar',
                          style: TextStyle(fontSize: 20),
                        ),
                        textColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        ),
                        elevation: 10,
                      ),
                      RaisedButton.icon(
                        onPressed: () {
                          Navigator.of(context).pushReplacementNamed(
                              MedicamentoEditarScreen.routeName,
                              arguments: medicamentoId);
                        },
                        icon: Icon(Icons.edit),
                        label: Text(
                          'Editar',
                          style: TextStyle(fontSize: 20),
                        ),
                        color: Colors.blue[700],
                        textColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        ),
                        elevation: 10,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
