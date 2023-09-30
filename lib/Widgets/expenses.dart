import 'package:expense_tracker/Widgets/Expense/expenseList.dart';
import 'package:expense_tracker/Widgets/chart/chart.dart';
import 'package:expense_tracker/Widgets/new_expense_bottom_sheet_overlay.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/Models/SingleExpense.dart';

class Expenses extends StatefulWidget {
  @override
  State<Expenses> createState() {
    // TODO: implement createState
    return _Expenses();
  }
}

class _Expenses extends State<Expenses> {
  final List<Expense> _registeredExpenses = [
    Expense(
        title: "Water",
        category: Category.food,
        amount: 15.66,
        date: DateTime.now()),
    Expense(
      title: "Watch",
      category: Category.work,
      amount: 299,
      date: DateTime.now(),
    ),
  ];

  void _addExpense(Expense expense) {
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  void _delExpense(Expense expense) {
    final index = _registeredExpenses.indexOf(expense);
    setState(() {
      _registeredExpenses.remove(expense);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content: const Text("Expense Deleted"),
          duration: const Duration(seconds: 3),
          action: SnackBarAction(
            label: 'Undo',
            onPressed: () {
              setState(() {
                _registeredExpenses.insert(index, expense);
              });
            },
          )),
    );
  }

  void _openAppExpenseOverlay() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (ctx) => BottomSheets(add: _addExpense),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    Widget content = const Center(
      child: Text("No expenses found!"),
    );
    if (_registeredExpenses.isNotEmpty) {
      content = ExpenseList(
        list: _registeredExpenses,
        onDelete: _delExpense,
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text("Expense Tracker"),
        actions: [
          IconButton(
              onPressed: _openAppExpenseOverlay, icon: const Icon(Icons.add))
        ],
      ),
      body: Column(
        children: [
          Chart(expenses: _registeredExpenses),
          Expanded(
            child: content,
          ),
        ],
      ),
    );
  }
}
