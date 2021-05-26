import 'package:flutter/material.dart';
import 'package:money_manager/pages/addAccount.dart';
import 'package:money_manager/pages/listAccounts.dart';
import 'package:money_manager/pages/listTransaction.dart';
import 'package:money_manager/pages/addTransaction.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/transaction',
      routes: {
        '/transaction': (context) => ListTransaction(),
        '/transaction/add': (context) => AddTransaction(),
        '/accounts': (context) => ListAccounts(),
        '/accounts/add': (context) => AddAccount(),
      },
    );
  }
}
