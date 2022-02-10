import 'dart:ui';

import 'package:despesas_pessoais/app/controllers/ExpensesController.dart';
import 'package:despesas_pessoais/app/generalUse/doubleToCurrency.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GraphCardOnBody extends StatelessWidget {
  final expensesController = Get.put(ExpensesController());
  @override
  Widget build(BuildContext context) {
    final Color background = Colors.grey;
    final Color fill = Colors.redAccent;
    final List<Color> gradient = [
      background,
      background,
      fill,
      fill,
    ];

    expensesController.sumAmountExpensesFunction();

    return Card(
      elevation: 10,
      child: Container(
          width: expensesController.widthFull * 0.95,
          height: expensesController.heightFull * 0.21,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Expanded(
                  child: Center(
                    child: ListView.builder(
                      itemCount: 7,
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        double sumAmountExpensesByDay = expensesController
                            .sumAmountExpensesByDayFunction(index);

                        return Padding(
                          padding: const EdgeInsets.all(4),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                '$sumAmountExpensesByDay',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: expensesController.widthFull * 0.014,
                                ),
                              ),
                              Container(
                                width: expensesController.widthFull * 0.03,
                                height: expensesController.heightFull * 0.11,
                                decoration: BoxDecoration(
                                  color: Colors.grey[350],
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(20),
                                  ),
                                  gradient: LinearGradient(
                                    colors: gradient,
                                    stops: expensesController.stops,
                                    end: Alignment.bottomCenter,
                                    begin: Alignment.topCenter,
                                  ),
                                ),
                              ),
                              Text(
                                '${expensesController.daysOfTheWeekList[index]}',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      '${expensesController.allExpensesList.length}D.',
                      style: TextStyle(
                          color: Colors.red, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Total das Despesas | R\$ ${doubleToCurrency(expensesController.sumAmountExpenses)}',
                      style: TextStyle(
                          color: Colors.red, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
          )),
    );
  }
}
