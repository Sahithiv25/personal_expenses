import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
class new_transaction extends StatefulWidget {
  final Function addTx;

  new_transaction(this.addTx);

  @override
  _new_transactionState createState() => _new_transactionState();
}

class _new_transactionState extends State<new_transaction> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  DateTime selectedDate;

  void _submitData(){
if(amountController.text.isEmpty){
  return;
}
    final enteredTitle = titleController.text;
    final enteredAmount = double.parse(amountController.text);

    if(enteredTitle.isEmpty || enteredAmount<=0 || selectedDate==null){
      return;
    }
    widget.addTx(
      enteredTitle,
      enteredAmount,
      selectedDate,
      );
    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2019),
        lastDate: DateTime.now()
    ).then((pickedDate) {
      if(pickedDate == null) {
        return ;
      }
      setState(() {
        selectedDate = pickedDate;
      });
          });

  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(top:10,left:10,right: 10,
              bottom: MediaQuery.of(context).viewInsets.bottom + 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextField(decoration: InputDecoration(labelText: 'Title'),
                controller: titleController,
                onSubmitted: (_)=>_submitData(),
//                  onChanged: (value){
//                  titleInput = value;
//                  },
              ),
              TextField(decoration: InputDecoration(labelText: 'Amount'),
                controller: amountController,
                keyboardType:TextInputType.number ,
                keyboardAppearance:Brightness.dark,
                onSubmitted: (_)=>_submitData(),
//                onChanged: (value){
//                  amountInput = value;
//                },
              ),

              Container(
                height: 70,
                child: Row(
                  children: <Widget>[
                    Expanded(

                      child: Text(selectedDate == null ?'No date shown':
                      'Picked Date: ${DateFormat.yMMMd().format(selectedDate)}'
                      ),
                    ),
                    FlatButton(
                      textColor: Theme.of(context).primaryColor,
                      child: Text('Choose Date',style:
                        TextStyle(
                          fontWeight:FontWeight.bold,
                        ),
                      ),
                      onPressed: _presentDatePicker,
                    ),
                  ],
                ),
              ),
              RaisedButton(child: Text('Add Item'),
                color: Theme.of(context).accentColor,
                textColor: Theme.of(context).primaryColor,
                onPressed: _submitData,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
