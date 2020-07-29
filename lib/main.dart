import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './new_transaction.dart';
import './transaction.dart';
import './transaction_list.dart';
import './chart.dart';
void main() {
//  WidgetsFlutterBinding.ensureInitialized();
//  SystemChrome.setPreferredOrientations([
//    DeviceOrientation.portraitUp,
//  DeviceOrientation.portraitDown,]);
  runApp(MyApp());

}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expenses',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        accentColor: Colors.green,
        errorColor: Colors.red,
        fontFamily: 'QuickSand',
        textTheme: ThemeData.light().textTheme.copyWith(title: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18,
          fontFamily: 'OpenSans',
        ),
        ),
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith
            (title: TextStyle(
            fontFamily: 'OpenSans',fontSize: 20,fontWeight: FontWeight.bold
          ),
          ),
        ),
      ),
      home: personal_expense(),
    );
  }
}


class personal_expense extends StatefulWidget {

//  String titleInput;
//  String amountInput;

  @override
  _personal_expenseState createState() => _personal_expenseState();
}

class _personal_expenseState extends State<personal_expense> {

  final List<Transaction> _userTransaction = [
//    Transaction(id: 't1',
//      title: 'New Clothes',
//      amount: 1400.00,
//      date: DateTime.now(),
//    ),
//    Transaction(id: 't2',
//      title: 'Food',
//      amount: 500.00,
//      date: DateTime.now(),
//    ),
  ];


  bool  _showChart = false;
  List<Transaction> get _recentTransactions {
    return _userTransaction.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(
        Duration(days: 7),
      ),
      );
    }).toList();

  }

  void _addNewTransaction(String txtitle, double txamount,DateTime chosenDate) {
    final newTx = Transaction(
      title: txtitle, amount: txamount,
      date: chosenDate, id: DateTime.now().toString(),
    );

    setState(() {
      _userTransaction.add(newTx);
    });
  }

    void _startnewtransaction(BuildContext ctx) {
      showModalBottomSheet(context: ctx, builder: (_) {
        return GestureDetector(
          onTap: () {},
            child: new_transaction(_addNewTransaction),
          behavior: HitTestBehavior.opaque,
        );
      },
      );
    }

    void _deleteTransaction(String id) {
        setState(() {
          _userTransaction.removeWhere((tx) => tx.id == id);


        });
    }

    @override
    Widget build(BuildContext context)
    {
      final mediaQuery = MediaQuery.of(context);
      final isLandscape = MediaQuery.of(context).orientation==Orientation.landscape;

      final appBar = AppBar(
            title: Text('Personal Expenses'),
            actions: <Widget>[
              IconButton(icon: Icon(Icons.add),
                onPressed: () => _startnewtransaction(context),
              ),
            ],
          );
      final txListWidget = Container(
          height: (MediaQuery.of(context).size.height-
              appBar.preferredSize.height-
              MediaQuery.of(context).padding.top)* 0.7,
          child: Transaction_list(_userTransaction,_deleteTransaction)
      );
      return  Scaffold(
          appBar: appBar,
          body: SingleChildScrollView(
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[

               if(isLandscape)  Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Switch.adaptive(value: _showChart,
                      onChanged:(val) {
                      setState(() {
                        _showChart = val;
                      });
                    },
                    ),
                    Text('Show Chart'),
                  ],
                ),
                if(!isLandscape)
                  Container(
                      height: (MediaQuery.of(context).size.height-
                          appBar.preferredSize.height -
                          MediaQuery.of(context).padding.top)* 0.7,
                      child: Chart(_recentTransactions)
                  ),
                if(!isLandscape) txListWidget,
               if(isLandscape) _showChart ?
                Container(
                  height: (MediaQuery.of(context).size.height-
                      appBar.preferredSize.height -
                      MediaQuery.of(context).padding.top)* 0.7,
                    child: Chart(_recentTransactions)) : txListWidget

              ],
            ),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () => _startnewtransaction(context),
          ),
        );
    }
  }



