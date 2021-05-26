import 'package:flutter/material.dart';
import 'package:money_manager/models/transaction.dart';

class TransactionListView extends StatelessWidget {
  final List<Transaction> transactions;

  TransactionListView(this.transactions);

  String formatAmount(Transaction trans) {
    if (trans.type == Type.income) return '₹ +${trans.amount}';
    if (trans.type == Type.expense) return '₹ -${trans.amount}';
    return 'Transfer';
  }

  Color getAmountColor(Transaction trans) {
    if (trans.type == Type.income) return Colors.greenAccent;
    if (trans.type == Type.expense) return Colors.redAccent;
    return Colors.grey[600];
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: transactions.length,
            itemBuilder: (context, index) {
              return Card(
                  color: Colors.transparent,
                  child: ListTile(
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        transactions[index].note != null
                            ? Text(
                                transactions[index].note,
                                style: TextStyle(
                                    color: Colors.grey[200], fontSize: 14),
                              )
                            : Container(),
                        Text(
                          transactions[index].account,
                          style:
                              TextStyle(color: Colors.grey[500], fontSize: 12),
                        ),
                      ],
                    ),
                    leading: Container(
                      padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                      width: 60,
                      child: Text(
                        transactions[index].category,
                        style: TextStyle(color: Colors.grey[500], fontSize: 12),
                      ),
                    ),
                    trailing: Container(
                      padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                      width: 80,
                      alignment: Alignment.center,
                      child: Text(
                        formatAmount(transactions[index]),
                        style: TextStyle(
                            color: getAmountColor(transactions[index]),
                            fontSize: 14),
                      ),
                    ),
                  ));
            }),
        TextButton(
            child: Text('Clear Transactions'),
            onPressed: () => TransactionList().clearAccounts()),
      ],
    );
  }
}
