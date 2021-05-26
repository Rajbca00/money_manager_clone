import 'package:flutter/material.dart';
import 'package:money_manager/models/account.dart';
import 'package:money_manager/widgets/accountListView.dart';
import 'package:money_manager/widgets/navigationBar.dart';

class ListAccounts extends StatefulWidget {
  @override
  _ListAccountsState createState() => _ListAccountsState();
}

class _ListAccountsState extends State<ListAccounts> {
  AccountsList list = AccountsList();
  List<Account> accounts = [];

  @override
  void initState() {
    super.initState();
    loadAccounts();
  }

  void addAccount(dynamic result) async {
    print(result);
    Account newAccount = Account(
      name: result['name'],
      group: result['group'],
      balance: result['balance'],
      description: result['description'],
    );

    await list.addAccount(newAccount);

    loadAccounts();
  }

  void loadAccounts() async {
    List<Account> items = await list.getAccounts();
    setState(() {
      accounts = items;
    });
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
            child: AccountsListView(accounts)),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.blueGrey[900],
          onPressed: () async {
            dynamic result =
                await Navigator.pushNamed(context, '/accounts/add');
            if (result != null) addAccount(result);
          },
          child: Icon(
            Icons.add,
          ),
        ),
        bottomNavigationBar: NavigationBar());
  }
}
