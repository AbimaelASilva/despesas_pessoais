import 'package:despesas_pessoais/app/controllers/ExpensesController.dart';
import 'package:despesas_pessoais/app/controllers/MySeachBarController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

final expensesController = Get.put(ExpensesController());

class MySeachBar extends StatelessWidget {
  final mySeachBarController = Get.put(MySeachBarController());
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextField(
          //  textAlignVertical: TextAlignVertical.center,
          textAlign: TextAlign.center,
          controller: mySeachBarController.textSeach,
          onChanged: (wordToFilter) =>
              expensesController.filterList(wordToFilter),
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.search),
            labelText: 'Buscar',
          ),
        ),
      ),
    );
  }
}
