import 'package:despesas_pessoais/app/controllers/ExpensesController.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

void registerNewExpense(BuildContext context) {
  final expensesController = Get.put(ExpensesController());
  Color myColorBlack = Color.fromRGBO(36, 38, 38, 1);
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Container(
        width: expensesController.widthFull,
        child: AlertDialog(
            backgroundColor: Colors.transparent,
            contentPadding: EdgeInsets.zero,
            insetPadding: EdgeInsets.only(
              right: expensesController.heightFull * 0.01,
              left: expensesController.heightFull * 0.01,
            ),
            elevation: 0.0,
            // title: Center(child: Text("Evaluation our APP")),
            content: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(30.0),
                        topLeft: Radius.circular(20.0),
                        //   bottomLeft: Radius.circular(20.0),
                        //   bottomRight: Radius.circular(20.0),
                      ),
                    ),
                    height: expensesController.heightFull * 0.5,
                    width: expensesController.widthFull,
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: myColorBlack,
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(20.0),
                              topLeft: Radius.circular(20.0),
                            ),
                          ),
                          width: double.infinity,
                          height: expensesController.heightFull * 0.07,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.app_registration_sharp,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                    expensesController.isEditing
                                        ? 'Editar despesa.'
                                        : 'Registrar nova despesa.',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize:
                                          expensesController.widthFull * 0.025,
                                      fontWeight: FontWeight.w500,
                                    )),
                              ],
                            ),
                          ),
                        ),
                        Divider(),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, bottom: 5),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Icon(
                                  Icons.description,
                                  color: Colors.red,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: TextField(
                                    controller:
                                        expensesController.titleController,
                                    decoration: InputDecoration(
                                        labelText: 'Título da despesa'),
                                    keyboardType: TextInputType.multiline,
                                    minLines: 1,
                                    maxLines: 2,
                                  ),
                                ),
                              ]),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, bottom: 5),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Icon(
                                  Icons.monetization_on_sharp,
                                  color: Colors.red,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: TextField(
                                      controller:
                                          expensesController.valueController,
                                      decoration: InputDecoration(
                                        labelText: 'Valor',
                                      ),
                                      keyboardType: TextInputType.number),
                                ),
                              ]),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, bottom: 5),
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
                                  child: GetBuilder<ExpensesController>(
                                      builder: (_) {
                                    return TextField(
                                      controller:
                                          expensesController.dateRegisterController,
                                      onTap: () => expensesController
                                          .selectDate(context, 'expenseDate'),
                                      decoration: InputDecoration(
                                        labelText: 'Data',
                                      ),
                                    );
                                  }),
                                ),
                              ]),
                        ),
                        GetBuilder<ExpensesController>(builder: (_) {
                          return _.inEditOrRegisterExpensesProcess
                              ? Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CircularProgressIndicator(),
                                      Text(expensesController.isEditing
                                          ? 'Atualizando despesa...'
                                          : 'Salvando despesa...')
                                    ],
                                  ),
                                )
                              : Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 20, right: 20, bottom: 5),
                                      child: Row(
                                          //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Expanded(
                                              child: ElevatedButton.icon(
                                                onPressed: () => expensesController
                                                    .verifyIfEmptyController(),
                                                label: Text(
                                                    expensesController.isEditing
                                                        ? 'Atualizar despesa.'
                                                        : 'Registrar'),
                                                icon: Icon(Icons.save),
                                                style: ButtonStyle(
                                                  backgroundColor:
                                                      MaterialStateProperty.all(
                                                          myColorBlack),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width:
                                                  expensesController.isEditing
                                                      ? 0
                                                      : 10,
                                            ),
                                            expensesController.isEditing
                                                ? Container()
                                                : Expanded(
                                                    child: ElevatedButton.icon(
                                                      onPressed: () =>
                                                          expensesController
                                                              .clearControllers(),
                                                      label:
                                                          Text('Nova despesa'),
                                                      icon: Icon(Icons
                                                          .fiber_new_sharp),
                                                      style: ButtonStyle(
                                                        backgroundColor:
                                                            MaterialStateProperty
                                                                .all(
                                                                    myColorBlack),
                                                      ),
                                                    ),
                                                  )
                                          ]),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 20, right: 20, bottom: 5),
                                      child: Container(
                                        width: expensesController.widthFull,
                                        child: ElevatedButton.icon(
                                          onPressed: () {
                                            expensesController.isEditing =
                                                false;
                                            expensesController
                                                .clearControllers();

                                            Get.back();
                                          },
                                          label: Text('Voltar'),
                                          icon: Icon(Icons.arrow_back),
                                        ),
                                      ),
                                    )
                                  ],
                                );
                        }),
                      ],
                    ),
                  ),
                ],
              ),
            )),
      );
    },
  );
}
