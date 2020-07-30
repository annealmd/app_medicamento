import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class Medicamento with ChangeNotifier {
  final int id;
  final String title;
  final String quantidade;
  final String dose;
  final int frequencia;
  final int duracao;
  final DateTime dataInicio;
  final DateTime horaInicio;
  final bool isContinuo;

  Medicamento({
    @required this.id,
    @required this.title,
    @required this.quantidade,
    @required this.dose,
    @required this.frequencia,
    this.duracao,
    @required this.dataInicio,
    @required this.horaInicio,
    @required this.isContinuo,
  });
}
