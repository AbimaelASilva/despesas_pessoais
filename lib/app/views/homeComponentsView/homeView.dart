import 'package:despesas_pessoais/app/controllers/ExpensesController.dart';
import 'package:despesas_pessoais/app/controllers/GenericController.dart';
import 'package:despesas_pessoais/app/controllers/MySeachBarController.dart';
import 'package:despesas_pessoais/app/generalUse/doubleToCurrency.dart';
import 'package:despesas_pessoais/app/generalUse/formateDate.dart';
import 'package:despesas_pessoais/app/generalUse/myTodayDate.dart';
import 'package:despesas_pessoais/app/models/ExpensesModel.dart';
import 'package:despesas_pessoais/app/repositories/ExpensesRepositorie.dart';
import 'package:despesas_pessoais/app/views/homeComponentsView/dateFilter.dart';
import 'package:despesas_pessoais/app/views/homeComponentsView/graphCardOnBody.dart';
import 'package:despesas_pessoais/app/views/homeComponentsView/registerNewExpense.dart';
import 'mySeachBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeView extends StatelessWidget {
  final expensesController = Get.put(ExpensesController());
  final mySeachBarController = Get.put(MySeachBarController());
  final genericController = Get.put(GenericController());

  HomeView() {
    genericController.updaHourMinute();
   
  }
  @override
  Widget build(BuildContext context) {
    setHeightAndWidht(context);
    /*   if (expensesController.allExpensesList.length == 0)
      expensesController.getAllExpanses();
      */

    return Scaffold(
      appBar: myAppBar(context),
      body: myBody(),
      floatingActionButton: myFloatingActionButton(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  myAppBar(BuildContext context) {
    return PreferredSize(
        preferredSize: Size.fromHeight(expensesController.heightFull * 0.13),
        child: Column(
          children: [
            AppBar(
              automaticallyImplyLeading: false,
              centerTitle: true,
              backgroundColor: Colors.black87,
              title: Text('Despesas Pessoais'),
              actions: [
                IconButton(
                  onPressed: () => registerNewExpense(context),
                  icon: Icon(
                    Icons.add,
                    color: Colors.yellow,
                  ),
                )
              ], // hides leading widget
            ),
            Container(
                color: Colors.black,
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text('Olá ${userController.logggedUser.name}!',
                          style: TextStyle(
                              color: Colors.orange,
                              fontSize: expensesController.widthFull * 0.015,
                              fontWeight: FontWeight.w500)),
                      Text('${myTodayDate()}',
                          style: TextStyle(
                              color: Colors.orange,
                              fontSize: expensesController.widthFull * 0.015,
                              fontWeight: FontWeight.w500)),
                      GetBuilder<GenericController>(builder: (_) {
                        return Text(
                          ' ${genericController.myTime} .',
                          style: TextStyle(
                              color: Colors.orange,
                              fontSize: expensesController.widthFull * 0.015,
                              fontWeight: FontWeight.w500),
                        );
                      }),
                    ],
                  ),
                )),
          ],
        ));
  }

  Widget myBody() => GetBuilder<ExpensesController>(builder: (_) {
        return expensesController.consultingExpense
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    Text('Carregando dados do Servidor...')
                  ],
                ),
              )
            : _.allExpensesList.length == 0
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.receipt_long_sharp),
                        Text('Você ainda não tem despesa registrada!')
                      ],
                    ),
                  )
                : SingleChildScrollView(
                    child: Container(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(children: [
                          GraphCardOnBody(),
                          rowSeachAndDate(),
                          expensesListOnBody(),
                        ]),
                      ),
                    ),
                  );
      });

  /*
       Widget myBody() => GetBuilder<ExpensesController>(builder: (_) {
        return !expensesController.consultingExpense
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.receipt_long_sharp),
                    Text('Você ainda não tem despesa registrada!')
                  ],
                ),
              )
            : _.allExpensesList.length == 0 && _.thereIsExpense
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(),
                        Text('Carregando dados do Servidor...')
                      ],
                    ),
                  )
                : SingleChildScrollView(
                    child: Container(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(children: [
                          GraphCardOnBody(),
                          MySeachBar(),
                          expensesListOnBody(),
                        ]),
                      ),
                    ),
                  );
      });
       */

  Widget rowSeachAndDate() {
    return Card(
      child: Row(
        children: [
          MySeachBar(),
          DateFilter(),
        ],
      ),
    );
  }

  Widget expensesListOnBody() {
    return Container(
      width: expensesController.widthFull,
      height: expensesController.heightFull * 0.52,
      child: ListView.builder(
          itemCount: expensesController.filteredExpensesList.length == 0
              ? expensesController.allExpensesList.length
              : expensesController.filteredExpensesList.length,
          itemBuilder: (BuildContext context, index) {
            // ExpensesModel expense = expensesController.allExpensesList[index];
            ExpensesModel expense =
                expensesController.filteredExpensesList.length == 0
                    ? expensesController.allExpensesList[index]
                    : expensesController.filteredExpensesList[index];
            return Card(
              child: Container(
                  height: expensesController.heightFull * 0.10,
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: 15, left: 10),
                        child: Container(
                          width: expensesController.heightFull * 0.08,
                          height: expensesController.heightFull * 0.08,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: Colors.black87),
                          child: Center(
                              child: Text(
                            //  'R\$\n ${expense.value.toStringAsFixed(2)}',
                            'R\$\n${doubleToCurrency(expense.value)}',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize:
                                    (doubleToCurrency(expense.value).length > 6
                                        ? 12
                                        : 15)),
                            textAlign: TextAlign.center,
                          )),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    '${expense.title}',
                                    style: TextStyle(
                                        color: Colors.black87,
                                        fontSize:
                                            expensesController.widthFull * 0.02,
                                        fontWeight: FontWeight.w900),
                                  ),
                                  Text(
                                    '${formateDate(expense.date)}',
                                    style: TextStyle(
                                        color: Colors.black87,
                                        fontSize:
                                            expensesController.widthFull * 0.02,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                              IconButton(
                                  onPressed: () {
                                    expensesController.isEditing = true;
                                    expensesController
                                            .inEditOrRegisterExpensesProcess =
                                        false;
                                    expensesController
                                        .loadControllersToEdit(expense);
                                    registerNewExpense(context);
                                  },
                                  icon: Icon(
                                    Icons.edit,
                                  ))
                            ],
                          ),
                        ),
                      ),
                    ],
                  )),
            );
          }),
    );
  }

  myFloatingActionButton(BuildContext context) {
    return FloatingActionButton(
      child: Icon(
        Icons.add,
        color: Colors.yellow,
      ),
      onPressed: () {
        expensesController.inEditOrRegisterExpensesProcess = false;
        registerNewExpense(context);
      },
      backgroundColor: Colors.black87,
    );
  }

  setHeightAndWidht(BuildContext context) {
    expensesController.heightFull = MediaQuery.of(context).size.height;
    expensesController.widthFull = MediaQuery.of(context).size.height;
  }
}

/**
 
  AppBar otherAppBar() => AppBar(
        centerTitle: true,
        backgroundColor: Colors.black87,
        title: Text('Despesas Pessoais'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.add,
              color: Colors.yellow,
            ),
          )
        ],
      );

 */