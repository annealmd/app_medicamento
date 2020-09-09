import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';

import '../providers/medicamento.dart';
import '../providers/medicamentos.dart';

class MedicamentoEditarScreen extends StatefulWidget {
  static const routeName = '/medicamento-editar';

  @override
  _MedicamentoEditarScreenState createState() =>
      _MedicamentoEditarScreenState();
}

class _MedicamentoEditarScreenState extends State<MedicamentoEditarScreen> {
  final _form = GlobalKey<FormState>();

  final _quantidadeFocusNode = FocusNode();
  final _frequenciaFocusNode = FocusNode();
  final _duracaoFocusNode = FocusNode();
  final _horaFocusNode = FocusNode();

  @override
  void dispose() {
    _quantidadeFocusNode.dispose();
    _frequenciaFocusNode.dispose();
    _duracaoFocusNode.dispose();
    _horaFocusNode.dispose();
    super.dispose();
  }

  final formatDate = DateFormat('dd/MM/yyyy', 'pt_Br');
  final formatTime = DateFormat(DateFormat.HOUR24_MINUTE, 'pt_Br');

  var _editedMedicamento = Medicamento(
    id: null,
    title: null,
    quantidade: '0',
    dose: null,
    frequencia: 4,
    duracao: 2,
    dataInicio: DateTime.now(),
    horaInicio: DateTime.now(),
    isContinuo: false,
  );
  var _isInit = true;
  var _isLoading = false;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final medicamentoId =
          ModalRoute.of(context).settings.arguments as int; // recebe Id
      if (medicamentoId != null) {
        _editedMedicamento = Provider.of<Medicamentos>(context, listen: false)
            .findById(medicamentoId);
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  void _saveForm() async {
    final isValid = _form.currentState.validate();
    if (!isValid) {
      return;
    }
    _form.currentState.save();
    setState(() {
      _isLoading = true;
    });
    //is loading
    if (_editedMedicamento.id != null) {
      await Provider.of<Medicamentos>(context, listen: false)
          .updateMedicamento(_editedMedicamento.id, _editedMedicamento);
    } else {
      await showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
                title: Text('Temos um erro!'),
                content: Text('Alguma coisa não saiu como esperado.'),
                actions: <Widget>[
                  FlatButton(
                      onPressed: () {
                        Navigator.of(ctx).pop();
                      },
                      child: Text('Ok'))
                ],
              ));
    }
    setState(() {
      _isLoading = false;
    });
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Medicamentos.avatarCor(_editedMedicamento.id),
        title: Text(
          'Editando',
          style: TextStyle(fontSize: 18),
        ),
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(16),
              child: SingleChildScrollView(
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  elevation: 10,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(top: 10, bottom: 5),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor:
                                Medicamentos.avatarCor(_editedMedicamento.id),
                            radius: 30,
                            child: Padding(
                              padding: EdgeInsets.all(6),
                              child: FittedBox(
                                  child: Text(_editedMedicamento.id.toString(),
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 50,
                                          fontWeight: FontWeight.bold))),
                            ),
                          ),
                          title: Text(
                            _editedMedicamento.title,
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
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(width: 10),
                                  Text(DateFormat('dd/MM/yyyy', 'pt_Br')
                                      .format(_editedMedicamento.dataInicio)),
                                ],
                              ),
                              _editedMedicamento.isContinuo
                                  ? Row(
                                      children: <Widget>[
                                        Text(
                                          'Final:',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(width: 10),
                                        Text('* Uso Contínuo *'),
                                      ],
                                    )
                                  : Row(
                                      children: <Widget>[
                                        Text(
                                          'Final:',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(width: 10),
                                        Text(
                                          DateFormat('dd/MM/yyyy', 'pt_Br')
                                              .format(
                                            _editedMedicamento.dataInicio.add(
                                              Duration(
                                                  days: _editedMedicamento
                                                      .duracao),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                              Row(
                                children: <Widget>[
                                  Text(
                                    'Horário inicial:',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(width: 10),
                                  Text(DateFormat(
                                          DateFormat.HOUR24_MINUTE, 'pt_Br')
                                      .format(_editedMedicamento.horaInicio)),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Divider(),
                      Padding(
                        padding: EdgeInsets.only(
                            top: 20,
                            left: 10,
                            right: 10,
                            bottom:
                                MediaQuery.of(context).viewInsets.bottom + 10),
                        child: Form(
                          key: _form,
                          //child: SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              TextFormField(
                                //inicialValue: _initValues['quantidade'],
                                decoration: InputDecoration(
                                  labelText:
                                      'Quantidade de ${_editedMedicamento.dose} :',
                                  labelStyle:
                                      TextStyle(fontWeight: FontWeight.bold),
                                  hintText: _editedMedicamento.quantidade,
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                ),
                                autofocus: true,
                                onFieldSubmitted: (_) {
                                  FocusScope.of(context)
                                      .requestFocus(_frequenciaFocusNode);
                                },
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.number,
                                validator: (value) {
                                  if (int.parse(value) > 100) {
                                    return 'Entre valor menor do que 100.';
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
                                      isContinuo:
                                          _editedMedicamento.isContinuo);
                                },
                              ),

                              Divider(), // FREQUENCIA
                              TextFormField(
                                decoration: InputDecoration(
                                  labelText: 'Frequência:',
                                  labelStyle:
                                      TextStyle(fontWeight: FontWeight.bold),
                                  hintText:
                                      '${_editedMedicamento.frequencia} horas ',
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                ),
                                focusNode: _frequenciaFocusNode,
                                onFieldSubmitted: (_) {
                                  FocusScope.of(context)
                                      .requestFocus(_duracaoFocusNode);
                                },
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.number,
                                validator: (value) {
                                  if (int.parse(value) > 24) {
                                    return 'Entre menor do que 24.';
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
                                      isContinuo:
                                          _editedMedicamento.isContinuo);
                                },
                              ),
                              Divider(), // DURACAO
                              _editedMedicamento.isContinuo
                                  ? Text(
                                      'Duração do tratamento é permanente',
                                      style: TextStyle(
                                          color: Colors.pink[700],
                                          fontWeight: FontWeight.bold),
                                    )
                                  : TextFormField(
                                      enabled: _editedMedicamento.isContinuo
                                          ? false
                                          : true,
                                      decoration: InputDecoration(
                                        labelText: 'Duração do Tratamento:',
                                        labelStyle: TextStyle(
                                            fontWeight: FontWeight.bold),
                                        hintText:
                                            '${_editedMedicamento.duracao} dias',
                                        filled: true,
                                        fillColor: Colors.white,
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                        ),
                                      ),
                                      textInputAction: TextInputAction.next,
                                      keyboardType: TextInputType.number,
                                      validator: (value) {
                                        if (int.parse(value) > 180) {
                                          return 'Entre menor do que 180';
                                        }
                                        return null;
                                      },
                                      onSaved: (value) {
                                        _editedMedicamento = Medicamento(
                                            id: _editedMedicamento.id,
                                            title: _editedMedicamento.title,
                                            quantidade:
                                                _editedMedicamento.quantidade,
                                            dose: _editedMedicamento.dose,
                                            frequencia:
                                                _editedMedicamento.frequencia,
                                            duracao: int.parse(value),
                                            dataInicio:
                                                _editedMedicamento.dataInicio,
                                            horaInicio:
                                                _editedMedicamento.horaInicio,
                                            isContinuo:
                                                _editedMedicamento.isContinuo);
                                      },
                                    ),
                              Divider(), //DATA

                              DateTimeField(
                                decoration: InputDecoration(
                                  labelText: 'Horário da primeira dose:',
                                  hintText: DateFormat(
                                          DateFormat.HOUR24_MINUTE, 'pt_Br')
                                      .format(_editedMedicamento.horaInicio),
                                  labelStyle:
                                      TextStyle(fontWeight: FontWeight.bold),
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
                                  ).then(
                                      (value) => DateTimeField.convert(value));
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
                                      isContinuo:
                                          _editedMedicamento.isContinuo);
                                },
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
                          //),
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
