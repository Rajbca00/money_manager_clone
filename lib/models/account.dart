import 'package:localstorage/localstorage.dart';
import 'package:money_manager/services/storage.dart';

enum AccountGroup {
  Cash,
  Card,
  DebitCard,
  Savings,
  Investments,
  Overdrafts,
  Loan
}

class Account {
  String name;
  AccountGroup group;
  double balance;
  String description;

  Account({this.name, this.group, this.balance, this.description});

  toJSONEncodable() {
    Map<String, Object> m = new Map();

    m['name'] = name;
    m['group'] = AccountGroup.values.indexOf(group);
    m['balance'] = balance;
    m['description'] = description;

    return m;
  }
}

class AccountsList {
  LocalStorage storage = Storage().storage;
  final String key = 'Accounts';

  _toJSONEncodable(List<Account> accounts) {
    return accounts.map((account) {
      return account.toJSONEncodable();
    }).toList();
  }

  //Get Accounts
  Future<List<Account>> getAccounts() async {
    await storage.ready;
    List<Account> accounts = [];

    var value = await storage.getItem(key);

    if (value != null) {
      accounts = List<Account>.from((value as List).map((item) => Account(
            balance: item['balance'],
            name: item['name'],
            description: item['description'],
            group: AccountGroup.values[item['group']],
          )));
    }
    return accounts;
  }

  //Add Account
  Future<List<Account>> addAccount(Account account) async {
    List<Account> accounts = await getAccounts();
    accounts.add(account);
    await storage.setItem(key, _toJSONEncodable(accounts));
    return accounts;
  }

  //Clear Accounts
  Future<void> clearAccounts() async {
    await storage.deleteItem(key);
    print('data cleared');
  }
}
