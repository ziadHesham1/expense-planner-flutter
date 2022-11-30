import 'package:expense_planner/widgets/new_transaction.dart';
import 'package:expense_planner/widgets/chart.dart';
import 'package:flutter/material.dart';
import 'package:expense_planner/models/transaction.dart';
import 'package:expense_planner/widgets/transaction_list.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expenses',
      home: const MyHomePage(),
      theme: ThemeData(
        primarySwatch: Colors.purple,
        fontFamily: 'Quicksand',
        appBarTheme: AppBarTheme(
            titleTextStyle: ThemeData.light()
                .textTheme
                .copyWith(
                  headline6: const TextStyle(
                    fontFamily: 'OpenSans',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                )
                .headline6),
        textTheme: ThemeData.light().textTheme.copyWith(
              headline6: const TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
      ),
    );
  }
}

var addIcon = const Icon(Icons.add);

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

@override
class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> transactions = [
    Transaction(
      id: 't1',
      title: 'New Shoes',
      amount: 2000000005,
      date: DateTime.now()
    ),
    Transaction(
      id: 't1',
      title: 'New Shoes',
      amount: 20,
      date: DateTime.now().subtract(const Duration(days: 1)),
    ),
    Transaction(
      id: 't1',
      title: 'New Shoes',
      amount: 20,
      date: DateTime.now().subtract(const Duration(days: 1)),
    ),
    Transaction(
      id: 't1',
      title: 'New Shoes',
      amount: 20,
      date: DateTime.now().subtract(const Duration(days: 3)),
    ),
    Transaction(
      id: 't1',
      title: 'New Shoes',
      amount: 20,
      date: DateTime.now().subtract(const Duration(days: 5)),
    ),
    Transaction(
      id: 't1',
      title: 'New Shoes',
      amount: 20,
      date: DateTime.now().subtract(const Duration(days: 7)),
    ),
    Transaction(
      id: 't1',
      title: 'New Shoes',
      amount: 20,
      date: DateTime.now().subtract(const Duration(days: 9)),
    ),
   
  ];

  List<Transaction> get _recentTranscations {
    var aWeekAgo = DateTime.now().subtract(const Duration(days: 7));
    return transactions.where(
      (tx) {
        return tx.date.isAfter(aWeekAgo) ;
      },
    ).toList();
  }


  final titleController = TextEditingController();

  final amountController = TextEditingController();

  void _addNewTransaction(String title, double amount) {
    final newTx = Transaction(
        id: 'T-${DateTime.now()}',
        title: title,
        amount: amount,
        date: DateTime.now());
    setState(() {
      transactions.add(newTx);
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return NewTransaction(_addNewTransaction);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter App'),
        actions: [
          IconButton(
            onPressed: () => _startAddNewTransaction(context),
            icon: addIcon,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Chart(_recentTranscations),
            TransactionList(transactions),
          
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () => _startAddNewTransaction(context),
        child: addIcon,
      ),
    );
  }
}
