import 'package:flutter/foundation.dart';
import 'package:localstorage/localstorage.dart';
import 'package:money_manager/pages/listTransaction.dart';
import 'package:money_manager/services/storage.dart';

enum Type { expense, income, transfer }

class Transaction {
  String datetime;
  String account;
  String category;
  String note;
  double amount;
  String description;
  Type type;
  String accountTo;

  Transaction(
      {@required this.datetime,
      @required this.account,
      @required this.category,
      this.note,
      @required this.amount,
      this.description,
      @required this.type,
      this.accountTo});

  _toJSONEncodable() {
    Map<String, dynamic> m = new Map();

    m['datetime'] = datetime;
    m['account'] = account;
    m['category'] = category;
    m['note'] = note;
    m['amount'] = amount;
    m['description'] = description;
    m['type'] = Type.values.indexOf(type);
    m['accountTo'] = accountTo;

    return m;
  }
}

class TransactionList {
  LocalStorage storage = Storage().storage;
  final String key = 'Transactions';

  //List<Transaction> _items = [];

  _toJSONEncodable(List<Transaction> items) {
    return items.map((item) {
      return item._toJSONEncodable();
    }).toList();
  }

  //Add Transaction
  Future<List<Transaction>> addTransactions(Transaction transaction) async {
    List<Transaction> list = await getTransactions();
    list.add(transaction);

    print(list);
    //Update storage
    await storage.setItem(key, _toJSONEncodable(list));
    return list;
  }

  //Get Transactions
  Future<List<Transaction>> getTransactions() async {
    await storage.ready;
    print('loading transaction');
    var value;

    value = await storage.getItem(key);

    print(value);

    List<Transaction> list = [];
    if (value != null) {
      list = List<Transaction>.from((value as List).map((item) => Transaction(
          datetime: item['date'],
          account: item['account'],
          category: item['category'],
          amount: item['amount'],
          note: item['note'],
          description: item['description'],
          type: Type.values[item['type']])));
    }
    return list;
  }

  //Clear Transactions
  Future<void> clearAccounts() async {
    await storage.deleteItem(key);
    print('data cleared');
  }
}
