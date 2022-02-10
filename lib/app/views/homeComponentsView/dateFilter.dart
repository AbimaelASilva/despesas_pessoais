import 'package:despesas_pessoais/app/controllers/ExpensesController.dart';
import 'package:despesas_pessoais/app/controllers/MySeachBarController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

final expensesController = Get.put(ExpensesController());

class DateFilter extends StatelessWidget {
  final mySeachBarController = Get.put(MySeachBarController());
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Icon(
              Icons.date_range_outlined,
              color: Colors.red,
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: GetBuilder<ExpensesController>(builder: (_) {
                return GestureDetector(
                  child: TextField(
                    controller: expensesController.startDateFilterController,
                    decoration: InputDecoration(
                      labelText: 'De',
                    ),
                    enabled: false,
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  ),
                  onTap: () =>
                      expensesController.selectDate(context, 'stardDateFilter'),
                );
              }),
            ),
            SizedBox(
              width: 5,
            ),
            Expanded(
              child: GetBuilder<ExpensesController>(builder: (_) {
                return GestureDetector(
                  child: TextField(
                    controller: expensesController.endDateFilterController,
                    decoration: InputDecoration(
                      labelText: 'Até',
                    ),
                    enabled: false,
                     style: TextStyle(
                      fontSize: 12,
                    ),
                  ),
                  onTap: () =>
                      expensesController.selectDate(context, 'endDateFilter'),
                );
              }),
            ),
          ]),
    );
  }
}
