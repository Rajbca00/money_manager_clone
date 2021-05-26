import 'package:flutter/material.dart';
import 'package:money_manager/models/account.dart';

class AccountsListView extends StatelessWidget {
  final List<Account> accounts;

  AccountsListView(this.accounts);

  String formatAmount(Account account) {
    return '₹ ${account.balance}';
  }

  Color getAmountColor(Account account) {
    if (account.balance > 0) return Colors.greenAccent;
    if (account.balance < 0) return Colors.redAccent;
    return Colors.white;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListView.builder(
            itemCount: accounts.length,
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return Card(
                  color: Colors.transparent,
                  child: ListTile(
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        accounts[index].name != null
                            ? Text(
                                accounts[index].name,
                                style: TextStyle(
                                    color: Colors.grey[200], fontSize: 14),
                              )
                            : Container(),
                        Text(
                          accounts[index].name,
                          style:
                              TextStyle(color: Colors.grey[500], fontSize: 12),
                        ),
                      ],
                    ),
                    leading: Container(
                      padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                      width: 60,
                      child: Text(
                        accounts[index].name,
                        style: TextStyle(color: Colors.grey[500], fontSize: 12),
                      ),
                    ),
                    trailing: Container(
                      padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                      width: 80,
                      alignment: Alignment.center,
                      child: Text(
                        formatAmount(accounts[index]),
                        style: TextStyle(
                            color: getAmountColor(accounts[index]),
                            fontSize: 14),
                      ),
                    ),
                  ));
            }),
        TextButton(
            child: Text('Clear Accounts'),
            onPressed: () => AccountsList().clearAccounts()),
      ],
    );
  }
}
