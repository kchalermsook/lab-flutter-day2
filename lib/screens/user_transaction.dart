import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';
import '../widgets/new_transaction.dart';

/// UserTransactions
class UserTransactionsScreen extends StatefulWidget {
  static const routeName = '/user-transaction';
  _UserTransactionsState createState() => _UserTransactionsState();
}

class _UserTransactionsState extends State<UserTransactionsScreen> {
  final List<Transaction> _transactions = [
    Transaction(
        id: 't1',
        title: 'Pay for Krapao Kai',
        amount: 200,
        date: DateTime.now()),
    Transaction(
        id: 't2',
        title: 'Buy the new notebook',
        amount: 20000,
        date: DateTime.now()),
  ];

  void addTransaction(String title, String amount) {
    setState(() {
      _transactions.add(Transaction(
          id: 't-new',
          title: title,
          amount: double.parse(amount),
          date: DateTime.now()));
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("User Transaction"),
      ),
      body: Column(
        children: [
          NewTransaction(addTransaction),
          ..._transactions.map((tx) {
            return _buildCard(tx);
          }).toList()
        ],
      ),
    );
  }

  Widget _buildCard(Transaction tx) => SizedBox(
        height: 210,
        child: Card(
          child: Column(
            children: [
              ListTile(
                title: Text(tx.title,
                    style: TextStyle(fontWeight: FontWeight.w500)),
                subtitle: Text(tx.id),
                leading: Icon(
                  Icons.insert_emoticon,
                  color: Colors.blue[500],
                ),
              ),
              Divider(),
              ListTile(
                title: Text(tx.amount.toString(),
                    style: TextStyle(fontWeight: FontWeight.w500)),
                leading: Icon(
                  Icons.attach_money,
                  color: Colors.blue[500],
                ),
              ),
              ListTile(
                title: Text(new DateFormat('dd/MM/yyyy')
                    .format(tx.date)), // วัน/เดือน/ปี
                leading: Icon(
                  Icons.today,
                  color: Colors.blue[500],
                ),
              ),
            ],
          ),
        ),
      );
}
