import 'package:flutter/material.dart';
import 'package:money_manager/widgets/customTextField.dart';
import 'package:money_manager/models/account.dart';
import 'package:money_manager/widgets/enumSelection.dart';
import 'package:money_manager/widgets/navigationBar.dart';
import 'package:enum_to_string/enum_to_string.dart';

class AddAccount extends StatefulWidget {
  String name;
  double balance;
  String description;
  String group;

  AddAccount({this.name, this.balance, this.description, this.group});

  @override
  _AddAccountState createState() => _AddAccountState();
}

class _AddAccountState extends State<AddAccount> {
  String groupValue = '';

  TextEditingController nameController = new TextEditingController();
  TextEditingController balanceController =
      new TextEditingController(text: '0');
  TextEditingController descriptionController = new TextEditingController();
  TextEditingController groupController;

  bool isGroupSelection = false;

  @override
  void initState() {
    super.initState();
    groupController = new TextEditingController(text: groupValue);

    if (widget.name != null)
      nameController = new TextEditingController(text: widget.name);
    if (widget.balance != null)
      balanceController =
          new TextEditingController(text: widget.balance.toString());
    if (widget.description != null)
      descriptionController =
          new TextEditingController(text: widget.description);
    if (widget.group != null)
      groupController = new TextEditingController(text: widget.group);
  }

  void setGroupSelectionFlag(bool flag) {
    print('set group selection');

    setState(() {
      isGroupSelection = flag;
    });
  }

  final _formKey = GlobalKey<FormState>();

  void submitAccount(BuildContext context) {
    if (_formKey.currentState.validate()) {
      // If the form is valid, display a snackbar. In the real world,
      // you'd often call a server or save the information in a database.
      // print(groupController.text);
      // print(AccountGroup.Cash);
      // print(AccountGroup.values.firstWhere((element) =>
      //     element.toString().split('.').last == groupController.text));
      Navigator.pop(context, {
        'name': nameController.text,
        'balance': double.parse(balanceController.text),
        'group': AccountGroup.values.firstWhere((element) =>
            element.toString().split('.').last == groupController.text),
        'description': descriptionController.text,
      });
    }
  }

  void onAccountGroupSelected(String accountGroup) {
    print('Account group' + accountGroup);

    setState(() {
      isGroupSelection = false;
      groupController = new TextEditingController(text: accountGroup);
    });
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
            Form(
              key: _formKey,
              child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: Column(
                    children: [
                      CustomTextField(
                        labelText: 'Name',
                        controller: nameController,
                        errorText: 'Please type Name',
                      ),
                      CustomTextField(
                        labelText: 'Balance',
                        controller: balanceController,
                        errorText: 'Please don\'t leave this field blank',
                        keyboardType: TextInputType.number,
                      ),
                      CustomTextField(
                          labelText: 'Group',
                          controller: groupController,
                          errorText: 'Please choose group',
                          readOnly: true,
                          onTap: setGroupSelectionFlag),
                      CustomTextField(
                          labelText: 'Description',
                          controller: descriptionController),
                      Divider(
                        height: 50,
                        thickness: 2,
                        color: Colors.black12,
                      ),
                      SizedBox(height: 20),
                      TextButton(
                          onPressed: () => submitAccount(context),
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
            isGroupSelection
                ? EnumSelection(
                    EnumToString.toList<AccountGroup>(AccountGroup.values),
                    onAccountGroupSelected)
                : Container(),
          ],
        ),
      ),
      bottomNavigationBar: NavigationBar(),
    );
  }
}
