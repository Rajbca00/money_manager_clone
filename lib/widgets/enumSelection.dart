import 'package:flutter/material.dart';

class EnumSelection extends StatelessWidget {
  final List<String> _enum;
  final Function onSelected;

  EnumSelection(this._enum, this.onSelected);

  @override
  Widget build(BuildContext context) {
    if (_enum == null) {
      return Center(
        child: Text(
            'Please create atleast one account before creating the transactions',
            style: TextStyle(color: Colors.grey[200])),
      );
    }
    return Column(children: [
      Container(
        child: Text('Account Groups',
            style: TextStyle(
              color: Colors.grey[200],
              fontSize: 16,
            )),
      ),
      SizedBox(height: 15),
      Wrap(direction: Axis.horizontal, children: [
        ..._enum
            .map((group) => GestureDetector(
                  onTap: () => onSelected(group),
                  child: Container(
                    margin: EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey[700],
                        width: 2,
                      ),
                    ),
                    width: MediaQuery.of(context).size.width * 0.30,
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                    child: Center(
                      child: Text(group.toString().split('.').last,
                          style: TextStyle(
                            color: Colors.grey[200],
                            fontSize: 16,
                          )),
                    ),
                  ),
                ))
            .toList()
      ])
    ]);
  }
}
