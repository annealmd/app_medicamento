import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../providers/medicamento.dart';
import '../providers/medicamentos.dart';

class MedicamentoAddScreen extends StatefulWidget {
  static const routeName = '/medicamento-add';

  @override
  _MedicamentoAddScreenState createState() => _MedicamentoAddScreenState();
}

class _MedicamentoAddScreenState extends State<MedicamentoAddScreen> {
  final _form = GlobalKey<FormState>();

  final _titleFocusNode = FocusNode();
  final _quantidadeFocusNode = FocusNode();
  final _doseFocusNode = FocusNode();
  final _frequenciaFocusNode = FocusNode();
  final _duracaoFocusNode = FocusNode();
  final _dataFocusNode = FocusNode();
  final _horaFocusNode = FocusNode();

  @override
  void dispose() {
    _titleFocusNode.dispose();
    _quantidadeFocusNode.dispose();
    _doseFocusNode.dispose();
    _frequenciaFocusNode.dispose();
    _duracaoFocusNode.dispose();
    _dataFocusNode.dispose();
    _horaFocusNode.dispose();
    super.dispose();
  }

  void showToast() {
    Fluttertoast.showToast(
      msg:
          'Atenção - o horário da PRIMEIRA DOSE e a frequência definem o ALARME. ',
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 5,
      backgroundColor: Colors.black87,
      textColor: Colors.white,
      fontSize: 16.0,
      webShowClose: true,
    );
  }

  String _doseSelecionada;
  bool checkboxValue = false;

  final formatDate = DateFormat('dd/MM/yyyy', 'pt_Br');
  final formatTime = DateFormat(DateFormat.HOUR24_MINUTE, 'pt_Br');

  var _editedMedicamento = Medicamento(
    id: 1,
    title: null,
    quantidade: '0',
    dose: null,
    frequencia: 4,
    duracao: 1,
    dataInicio: DateTime.now(),
    horaInicio: DateTime.now(),
    isContinuo: false,
  );

  void _saveForm() {
    final isValid = _form.currentState.validate();
    if (!isValid) {
      return;
    }
    _form.currentState.save();
    Provider.of<Medicamentos>(context, listen: false).addMedicamento(
        _editedMedicamento.id,
        _editedMedicamento.title,
        _editedMedicamento.quantidade,
        _editedMedicamento.dose,
        _editedMedicamento.frequencia,
        _editedMedicamento.duracao,
        _editedMedicamento.dataInicio,
        _editedMedicamento.horaInicio,
        _editedMedicamento.isContinuo);    

    Navigator.of(context).pop('/user-medicamentos');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: <Widget>[
            Text(
              'Novo  ',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              'Medicamento ',
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
        backgroundColor: Colors.blueGrey[700],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            stops: [0.1, 0.4, 0.6, 0.9],
            colors: [
              Colors.green[50],
              Colors.yellow[50],
              Colors.green[50],
              Colors.yellow[50],
            ],
          ),
        ),
        child: Padding(
          padding: EdgeInsets.only(top: 30, left: 20, right: 20, bottom: 10),
          child: Form(
            key: _form,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Medicamento:',
                      labelStyle: TextStyle(fontWeight: FontWeight.bold),
                      hintText: 'ex: clorofila',
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                    textInputAction: TextInputAction.next,
                    autofocus: true,
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(_quantidadeFocusNode);
                    },
                    validator: (value) {
                      if (value.length > 30) {
                        return 'Nome muito grande.';
                      } else if (value == null) {
                        return 'Entre nome';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _editedMedicamento = Medicamento(
                          id: Provider.of<Medicamentos>(context, listen: false)
                              .medicamentoId(),
                          title: value,
                          quantidade: _editedMedicamento.quantidade,
                          dose: _editedMedicamento.dose,
                          frequencia: _editedMedicamento.frequencia,
                          duracao: _editedMedicamento.duracao,
                          dataInicio: _editedMedicamento.dataInicio,
                          horaInicio: _editedMedicamento.horaInicio,
                          isContinuo: _editedMedicamento.isContinuo);
                    },
                  ),
                  Divider(), // QUANTIDADE
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Quantidade:',
                      labelStyle: TextStyle(fontWeight: FontWeight.bold),
                      hintText: 'ex: 2',
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.number,
                    focusNode: _quantidadeFocusNode,
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(_doseFocusNode);
                    },
                    validator: (value) {
                      if (int.parse(value) > 101) {
                        return 'Máximo 100.';
                      } else if (value == null) {
                        return 'Entre valor';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _editedMedicamento = Medicamento(
                          id: _editedMedicamento.id,
                          title: _editedMedicamento.title,
                          quantidade: value,
                          dose: _editedMedicamento.dose,
                          frequencia: _editedMedicamento.frequencia,
                          duracao: _editedMedicamento.duracao,
                          dataInicio: _editedMedicamento.dataInicio,
                          horaInicio: _editedMedicamento.horaInicio,
                          isContinuo: _editedMedicamento.isContinuo);
                    },
                  ),
                  Divider(), // DOSE
                  DropdownButtonFormField(
                    decoration: InputDecoration(
                      labelText: 'Escolha a Dose:',
                      labelStyle: TextStyle(fontWeight: FontWeight.bold),
                      hintText: 'Selecione',
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                    icon: Icon(Icons.arrow_drop_down,
                        color: Colors.green[700], size: 40),
                    value: _doseSelecionada,
                    items: <String>[
                      'cápsulas',
                      'gotas',
                      'ml',
                      'gramas',
                      'colher',
                      'unidade'
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    validator: (value) {
                      if (value == null) {
                        return 'Escolha tipo de dose';
                      }
                      return null;
                    },
                    onChanged: (String value) {
                      setState(() => _doseSelecionada = value);
                      _editedMedicamento = Medicamento(
                          id: _editedMedicamento.id,
                          title: _editedMedicamento.title,
                          quantidade: _editedMedicamento.quantidade,
                          dose: value,
                          frequencia: _editedMedicamento.frequencia,
                          duracao: _editedMedicamento.duracao,
                          dataInicio: _editedMedicamento.dataInicio,
                          horaInicio: _editedMedicamento.horaInicio,
                          isContinuo: _editedMedicamento.isContinuo);

                      FocusScope.of(context).requestFocus(_frequenciaFocusNode);
                    },
                  ),

                  Divider(), // FREQUENCIA
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Frequência:',
                      labelStyle: TextStyle(fontWeight: FontWeight.bold),
                      hintText: 'ex: 12 em 12h',
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.number,
                    focusNode: _frequenciaFocusNode,
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(_duracaoFocusNode);
                      showToast();
                    },
                    validator: (value) {
                      if (int.parse(value) > 25) {
                        return 'Máximo 24.';
                      } else if (value == null) {
                        return 'Entre valor';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _editedMedicamento = Medicamento(
                          id: _editedMedicamento.id,
                          title: _editedMedicamento.title,
                          quantidade: _editedMedicamento.quantidade,
                          dose: _editedMedicamento.dose,
                          frequencia: int.parse(value),
                          duracao: _editedMedicamento.duracao,
                          dataInicio: _editedMedicamento.dataInicio,
                          horaInicio: _editedMedicamento.horaInicio,
                          isContinuo: _editedMedicamento.isContinuo);
                    },
                  ),
                  Divider(), // DURACAO
                  CheckboxListTile(
                    value: checkboxValue,
                    onChanged: (bool val) {
                      setState(() => checkboxValue = true);
                      _editedMedicamento = Medicamento(
                          id: _editedMedicamento.id,
                          title: _editedMedicamento.title,
                          quantidade: _editedMedicamento.quantidade,
                          dose: _editedMedicamento.dose,
                          frequencia: _editedMedicamento.frequencia,
                          duracao: _editedMedicamento.duracao,
                          dataInicio: _editedMedicamento.dataInicio,
                          horaInicio: _editedMedicamento.horaInicio,
                          isContinuo: checkboxValue);
                    },
                    title: Text(
                      '* Uso Contínuo. *',
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.bold),
                    ),
                    controlAffinity: ListTileControlAffinity.leading,
                  ),
                  // Divider(),
                  _editedMedicamento.isContinuo
                      ? Text('Duração do tratamento é permanente')
                      : TextFormField(
                          enabled: _editedMedicamento.isContinuo ? false : true,
                          decoration: InputDecoration(
                            labelText: 'Duração do Tratamento:',
                            labelStyle: TextStyle(fontWeight: FontWeight.bold),
                            hintText: 'ex: 10 dias',
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                          ),
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.number,
                          focusNode: _duracaoFocusNode,
                          onFieldSubmitted: (_) {
                            FocusScope.of(context).requestFocus(_dataFocusNode);
                          },
                          validator: (value) {
                            if (int.parse(value) > 180) {
                              return 'Máximo 180, marque contínuo';
                            } else if (value == null) {
                              return 'Entre valor ou marque Contínuo';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _editedMedicamento = Medicamento(
                                id: _editedMedicamento.id,
                                title: _editedMedicamento.title,
                                quantidade: _editedMedicamento.quantidade,
                                dose: _editedMedicamento.dose,
                                frequencia: _editedMedicamento.frequencia,
                                duracao: int.parse(value),
                                dataInicio: _editedMedicamento.dataInicio,
                                horaInicio: _editedMedicamento.horaInicio,
                                isContinuo: _editedMedicamento.isContinuo);
                          },
                        ),
                  Divider(),
                  //DATA
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      DateTimeField(
                        focusNode: _dataFocusNode,
                        decoration: InputDecoration(
                          labelText: 'Início do Tratamento:',
                          labelStyle: TextStyle(fontWeight: FontWeight.bold),
                          hintText: 'ex: 10/09/2020',
                          filled: true,
                          fillColor: Colors.white,
                          prefixIcon: Icon(Icons.calendar_today),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                        format: formatDate,
                        onShowPicker: (context, currentValue) {
                          return showDatePicker(
                              context: context,
                              firstDate: DateTime(2020),
                              initialDate: currentValue ?? DateTime.now(),
                              lastDate: DateTime(2100));
                        },
                        validator: (value) {
                          if (value == null) {
                            return 'Escolha data de início';
                          }
                          return null;
                        },
                        onSaved: (currentValue) {
                          _editedMedicamento = Medicamento(
                              id: _editedMedicamento.id,
                              title: _editedMedicamento.title,
                              quantidade: _editedMedicamento.quantidade,
                              dose: _editedMedicamento.dose,
                              frequencia: _editedMedicamento.frequencia,
                              duracao: _editedMedicamento.duracao,
                              dataInicio: currentValue,
                              horaInicio: _editedMedicamento.horaInicio,
                              isContinuo: _editedMedicamento.isContinuo);
                        },
                      ),
                      Divider(),
                      DateTimeField(
                        focusNode: _horaFocusNode,
                        decoration: InputDecoration(
                          labelText: 'Horário da primeira dose:',
                          //hintText: '19:30H',
                          labelStyle: TextStyle(fontWeight: FontWeight.bold),
                          prefixIcon: Icon(Icons.alarm),
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                        format: formatTime,
                        onShowPicker: (context, currentValue) async {
                          return await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.fromDateTime(
                                currentValue ?? DateTime.now()),
                          ).then((value) => DateTimeField.convert(value));
                        },
                        validator: (value) {
                          if (value == null) {
                            return 'Escolha hora de início';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _editedMedicamento = Medicamento(
                            id: _editedMedicamento.id,
                            title: _editedMedicamento.title,
                            quantidade: _editedMedicamento.quantidade,
                            dose: _editedMedicamento.dose,
                            frequencia: _editedMedicamento.frequencia,
                            duracao: _editedMedicamento.duracao,
                            dataInicio: _editedMedicamento.dataInicio,
                            horaInicio: value,
                            isContinuo: _editedMedicamento.isContinuo,
                          );
                        },
                      ),
                    ],
                  ),
                  //DATA

                  Container(
                    width: MediaQuery.of(context).size.width * 0.60,
                    margin: EdgeInsets.symmetric(vertical: 20),
                    child: RaisedButton.icon(
                      onPressed: _saveForm,
                      icon: Icon(Icons.save),
                      label: Text(
                        'Salvar',
                        style: TextStyle(fontSize: 20),
                      ),
                      color: Colors.green[700],
                      textColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                      elevation: 5,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
