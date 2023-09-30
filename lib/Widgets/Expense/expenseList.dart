import 'package:expense_tracker/Widgets/Expense/SingleItemExpense.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/Models/SingleExpense.dart';

class ExpenseList extends StatefulWidget {
  ExpenseList({super.key, required this.list, required this.onDelete});

  final List<Expense> list;
  void Function(Expense expense) onDelete;

  @override
  State<ExpenseList> createState() {
    return _ExpenseList();
  }
}

class _ExpenseList extends State<ExpenseList> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListView.builder(
      itemCount: widget.list.length,
      itemBuilder: (ctx, index) => Dismissible(
        key: ValueKey(widget.list[index]),
        background: Container(
          color: Theme.of(context).colorScheme.error,
          margin: EdgeInsets.symmetric(
            horizontal: Theme.of(context).cardTheme.margin!.horizontal,
            vertical: Theme.of(context).cardTheme.margin!.vertical,
          ),
        ),
        onDismissed: (direction) {
          widget.onDelete(widget.list[index]);
        },
        child: SingleItemExpense(widget.list[index]),
      ),
    );

    // TODO: My implementation
    // return Column(
    //   children: [
    //     ...widget.list.map((data){
    //       return Row(
    //         children: [
    //           Expanded(
    //             child: Column(children: [Text(data.title.toString()),
    //               Text(data.date.toString()),
    //             ]),
    //           ),
    //           Text(data.amount.toString()),
    //         ],
    //       );
    //     })
    //   ],
    // );
  }
}
