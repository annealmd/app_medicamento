import 'package:flutter/material.dart';

import './medicamento.dart';
import '../helpers/db_helper.dart';
import './notification.dart';

class Medicamentos with ChangeNotifier {
  List<Medicamento> _items = [];
  final NotificationManager alarme = NotificationManager();

  static Color avatarCor(int id) {
    switch (id) {
      case 1:
        return Colors.blue.shade700;
      case 2:
        return Colors.pink.shade700;
      case 3:
        return Colors.green.shade700;
      case 4:
        return Colors.yellow.shade700;
      case 5:
        return Colors.red.shade700;
      case 6:
        return Colors.teal.shade700;
      case 7:
        return Colors.purple.shade600;
      case 8:
        return Colors.indigo.shade700;
      case 9:
        return Colors.orange.shade700;
      case 10:
        return Colors.cyan.shade700;
      default:
        return Colors.blueGrey.shade700;
    }
  }

  List<Medicamento> get items {
    return [..._items];
  }

  Medicamento findById(int id) {
    return _items.firstWhere((element) => element.id == id);
  }

  Future<void> medicamentoDelete(int frequencia, int medId) async {
    deleteAlarmes(frequencia, medId);
    await DBHelper.deleteMedicamento('user_medicamentos', medId);
    _items.removeWhere((element) => element.id == medId);

    notifyListeners();
  }

  Future<void> updateMedicamento(int id, Medicamento novoMedicamento) async {
    _items[id - 1] = novoMedicamento;
    notifyListeners();
    deleteAlarmes(novoMedicamento.frequencia, novoMedicamento.id);
    _addAlarmes(
        novoMedicamento.frequencia,
        novoMedicamento.horaInicio,
        novoMedicamento.id,
        novoMedicamento.title,
        novoMedicamento.quantidade,
        novoMedicamento.dose);
    await DBHelper.updateMedicamento(
        'user_medicamentos',
        {
          'id': novoMedicamento.id,
          'title': novoMedicamento.title,
          'quantidade': novoMedicamento.quantidade,
          'dose': novoMedicamento.dose,
          'frequencia': novoMedicamento.frequencia,
          'duracao': novoMedicamento.duracao,
          'dataInicio': novoMedicamento.dataInicio.toIso8601String(),
          'horaInicio': novoMedicamento.horaInicio.toIso8601String(),
          'isContinuo': novoMedicamento.isContinuo ? 1 : 0,
        },
        novoMedicamento.id);
  }

  int medicamentoId() {
    int id;
    if (_items.isEmpty) {
      id = 1;
      return id;
    } else {
      id = _items.last.id + 1;
    }
    for (var i = 1; i <= _items.length; i++) {
      if (_items[i - 1].id != i) {
        id = i;
        break;
      }
    }
    return id;
  }

  //alarmes
  void _addAlarmes(int frequencia, DateTime horaInicio, int medId,
      String medTitle, String quantidade, String dose) async {
    for (var i = 0; i < (24 / frequencia); i++) {
      await alarme.dailyNotification(
          horaInicio.add(Duration(hours: (frequencia * i))),
          medId,
          medTitle.toUpperCase(),
          i,
          quantidade,
          dose);
    }
  }

  void deleteAlarmes(int frequencia, int medId) async {
    for (var i = 0; i < (24 / frequencia); i++) {
      var alarmeId = (100 * medId) + i;
      await alarme.deleteNotification(alarmeId);
    }
  }

  void addMedicamento(
    int id,
    String title,
    String quantidade,
    String dose,
    int frequencia,
    int duracao,
    DateTime dataInicio,
    DateTime horaInicio,
    bool isContinuo,
  ) {
    final novoMedicamento = Medicamento(
      id: id,
      title: title,
      quantidade: quantidade,
      dose: dose,
      frequencia: frequencia,
      duracao: duracao,
      dataInicio: dataInicio,
      horaInicio: horaInicio,
      isContinuo: isContinuo,
    );

    _items.add(novoMedicamento);
    notifyListeners();
    //notifications
    _addAlarmes(frequencia, horaInicio, id, title, quantidade, dose);

    DBHelper.insert('user_medicamentos', {
      'id': novoMedicamento.id,
      'title': novoMedicamento.title,
      'quantidade': novoMedicamento.quantidade,
      'dose': novoMedicamento.dose,
      'frequencia': novoMedicamento.frequencia,
      'duracao': novoMedicamento.duracao,
      'dataInicio': dataInicio.toIso8601String(),
      'horaInicio': horaInicio.toIso8601String(),
      'isContinuo': isContinuo ? 1 : 0,
    });
  }

  Future<void> fetchAndSetMedicamento() async {
    final dataList = await DBHelper.getData('user_medicamentos');
    print('****** Print from DATAbase rows');
    DBHelper.getCount();
    dataList.forEach((row) => print(row));

    _items = dataList
        .map((item) => Medicamento(
              id: item['id'],
              title: item['title'],
              quantidade: item['quantidade'],
              dose: item['dose'],
              frequencia: item['frequencia'],
              duracao: item['duracao'],
              dataInicio: DateTime.parse(item['dataInicio']),
              horaInicio: DateTime.parse(item['horaInicio']),
              isContinuo: item['isContinuo'] == 1 ? true : false,
            ))
        .toList();
    medFinalizados();
    notifyListeners();
  }

  void medFinalizados() {
    for (var i = 0; i < _items.length; i++) {
      if (_items[i]
          .dataInicio
          .add(Duration(
              days: _items[i].duracao,
              hours: _items[i].horaInicio.hour,
              minutes: _items[i].horaInicio.minute + 10))
          .isBefore(DateTime.now())) {
        medicamentoDelete(_items[i].frequencia, _items[i].id);
      }
    }
  }
}
