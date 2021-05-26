import 'package:flutter/material.dart';
import 'package:money_manager/models/transaction.dart';
import 'package:money_manager/widgets/transactionListView.dart';
import 'package:money_manager/widgets/navigationBar.dart';

class ListTransaction extends StatefulWidget {
  @override
  _ListTransactionState createState() => _ListTransactionState();
}

class _ListTransactionState extends State<ListTransaction> {
  TransactionList list = TransactionList();
  List<Transaction> transactions = [];

  @override
  void initState() {
    super.initState();
    loadTransactions();
  }

  void loadTransactions() async {
    List<Transaction> items = await list.getTransactions();
    print(items.map((account) => account.account).toList());
    setState(() {
      transactions = items;
    });
  }

  void addTransaction(dynamic result) async {
    Transaction newTransaction = Transaction(
        datetime: result['datetime'],
        account: result['account'],
        category: result['category'],
        amount: result['amount'],
        note: result['note'],
        description: result['description'],
        type: result['type']);

    print('new transaction');
    print(newTransaction.datetime);

    await list.addTransactions(newTransaction);

    loadTransactions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blueGrey[800],
        appBar: AppBar(
          title: Text('Money Manager'),
          centerTitle: true,
          backgroundColor: Colors.blueGrey[900],
        ),
        body: Padding(
            padding: const EdgeInsets.fromLTRB(10, 5, 10, 0),
            child: TransactionListView(transactions)),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.blueGrey[900],
          onPressed: () async {
            dynamic result =
                await Navigator.pushNamed(context, '/transaction/add');
            //print(result);
            addTransaction(result);
          },
          child: Icon(
            Icons.add,
          ),
        ),
        bottomNavigationBar: NavigationBar());
  }
}
