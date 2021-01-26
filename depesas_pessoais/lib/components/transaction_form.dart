
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionForm extends StatefulWidget {
  final void Function(String, double, DateTime) onSubmit;

  TransactionForm(this.onSubmit);

  @override
  _TransactionFormState createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  bool error = false;
  final _titleController = TextEditingController();
  final _valueController = TextEditingController();
  DateTime _selectDate = DateTime.now();

  _submitForm() {
    final title = _titleController.text ?? "Sem Texto";
    final value = double.tryParse(_valueController.text) ?? 0.0;
    if (title.isEmpty || value <= 0 || _selectDate == null) {
      setState(() {
        error = true;
      });
      return;
    }
    setState(() {
      error = false;
    });
    widget.onSubmit(title, value, _selectDate);
  }

  _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    ).then((picksDate) {
      if (picksDate == null) {
        return;
      } else {
        setState(() {
          _selectDate = picksDate;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Card(
          elevation: 5,
          child: Padding(
            padding: EdgeInsets.only(
                top: 10,
                right: 10,
                left: 10,
                bottom: 10 +  MediaQuery.of(context).viewInsets.bottom),
            child: Column(
              children: <Widget>[
                TextField(
                  controller: _titleController,
                  decoration: InputDecoration(labelText: "Titulo"),
                ),
                TextField(
                  
                  controller: _valueController,
                  onSubmitted: (_) => _submitForm(),
                  decoration: InputDecoration(labelText: "Valor R\$"),
                  keyboardType: TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                FittedBox(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        _selectDate == null
                            ? "Nenhuma data selecionada"
                            : "Data Selecionada : " +
                                DateFormat('dd/M/y').format(_selectDate),
                      ),
                      FlatButton(
                        textColor: Colors.black,
                        onPressed: _showDatePicker,
                        child: Text(
                          "Selecionar Data",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 50,
                  child: RaisedButton(
                    color: Colors.grey[800],
                    onPressed: () {
                      _submitForm();
                      // print(_valueController.text);
                      // print(_valueController);
                    },
                    child: Text(
                      "Nova Transação",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: error ? Colors.red : Colors.white,
                      ),
                    ),
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
