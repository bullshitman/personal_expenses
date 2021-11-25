import 'package:flutter/material.dart';
import 'package:personal_expenses/models/transaction.dart';
import 'package:intl/intl.dart';
import 'package:personal_expenses/widgets/chart_bar.dart';

class Chart extends StatelessWidget {
  final List<Transaction> _recentTransactions;

  Chart(this._recentTransactions);

  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      double totalSumm = 0.0;
      for (int i = 0; i < _recentTransactions.length; i++) {
        if (_recentTransactions[i].date.day == weekDay.day &&
            _recentTransactions[i].date.month == weekDay.month &&
            _recentTransactions[i].date.year == weekDay.year) {
          totalSumm += _recentTransactions[i].amount;
        }
      }
      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'amount': totalSumm
      };
    }).reversed.toList();
  }

  double get totalSpending {
    return groupedTransactionValues.fold(0.0, (previousValue, element) {
      return previousValue + element['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Container(
        // padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactionValues.map((element) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                element['day'],
                element['amount'],
                totalSpending == 0.0
                    ? 0.0
                    : (element['amount'] as double) / totalSpending,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
