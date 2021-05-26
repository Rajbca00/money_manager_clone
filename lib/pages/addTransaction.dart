import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:money_manager/models/account.dart';
import 'package:money_manager/widgets/customTextField.dart';
import 'package:money_manager/widgets/dateTimePicker.dart';
import 'package:money_manager/models/transaction.dart';
import 'package:money_manager/widgets/customOutlineButton.dart';
import 'package:money_manager/widgets/enumSelection.dart';
import 'package:money_manager/widgets/navigationBar.dart';

class AddTransaction extends StatefulWidget {
  @override
  _AddTransactionState createState() => _AddTransactionState();
}

class _AddTransactionState extends State<AddTransaction> {
  TextEditingController accountController = new TextEditingController();
  TextEditingController categoryController = new TextEditingController();
  TextEditingController amountController = new TextEditingController();
  TextEditingController noteController = new TextEditingController();
  TextEditingController descriptionController = new TextEditingController();
  TextEditingController dateController =
      new TextEditingController(text: DateTime.now().toString());

  List<Account> accounts;

  bool isAccountSelection = false;

  Type transactionType = Type.expense;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    loadAccounts();
  }

  void loadAccounts() async {
    accounts = await AccountsList().getAccounts();
  }

  void setAccountSelectionFlag(bool flag) {
    setState(() {
      isAccountSelection = flag;
    });
  }

  void switchTransactionType(Type type) {
    setState(() {
      transactionType = type;
    });
  }

  void onAccountSelected(String account) {
    setState(() {
      isAccountSelection = false;
      accountController = new TextEditingController(text: account);
    });
  }

  void submitTransaction(BuildContext context) {
    if (_formKey.currentState.validate()) {
      // If the form is valid, display a snackbar. In the real world,
      // you'd often call a server or save the information in a database.
      Navigator.pop(context, {
        'datetime': dateController.text,
        'account': accountController.text,
        'category': categoryController.text,
        'amount': double.parse(amountController.text),
        'note': noteController.text,
        'description': descriptionController.text,
        'type': transactionType
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.blueGrey[800],
      appBar: AppBar(
        title: Text('Add Transaction', style: TextStyle(fontSize: 16)),
        backgroundColor: Colors.blueGrey[900],
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomOutlineButton(
                  onPressed: () {
                    switchTransactionType(Type.income);
                  },
                  text: 'Income',
                  isActive: transactionType == Type.income,
                ),
                SizedBox(width: 10),
                CustomOutlineButton(
                  onPressed: () {
                    switchTransactionType(Type.expense);
                  },
                  text: 'Expense',
                  isActive: transactionType == Type.expense,
                ),
                SizedBox(width: 10),
                CustomOutlineButton(
                  onPressed: () {
                    switchTransactionType(Type.transfer);
                  },
                  text: 'Transfer',
                  isActive: transactionType == Type.transfer,
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Form(
              key: _formKey,
              child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: Column(
                    children: [
                      CustomDateTimePicker(
                        label: 'Date',
                        controller: dateController,
                        dateFormat: DateFormat("dd/MM/yy HH:mm"),
                      ),
                      CustomTextField(
                          labelText: 'Account',
                          controller: accountController,
                          errorText: 'Please choose Account',
                          readOnly: true,
                          onTap: setAccountSelectionFlag),
                      CustomTextField(
                        labelText: 'Category',
                        controller: categoryController,
                        errorText: 'Please choose Category',
                      ),
                      CustomTextField(
                        labelText: 'Amount',
                        controller: amountController,
                        keyboardType: TextInputType.number,
                        errorText: 'Please enter Amount',
                      ),
                      CustomTextField(
                          labelText: 'Note', controller: noteController),
                      Divider(
                        height: 50,
                        thickness: 10,
                        color: Colors.black12,
                      ),
                      CustomTextField(
                        controller: descriptionController,
                        hintText: 'Description',
                      ),
                      SizedBox(height: 20),
                      TextButton(
                          onPressed: () => submitTransaction(context),
                          child: Container(
                              width: double.infinity,
                              height: 45,
                              decoration: BoxDecoration(
                                  color: Colors.redAccent,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Center(
                                  child: Text(
                                'Save',
                                style: TextStyle(color: Colors.white),
                              ))))
                    ],
                  )),
            ),
            isAccountSelection
                ? EnumSelection(
                    accounts?.map((account) => account.name)?.toList(),
                    onAccountSelected)
                : Container(),
          ],
        ),
      ),
      //bottomNavigationBar: NavigationBar(),
    );
  }
}
