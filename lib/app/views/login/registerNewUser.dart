import 'package:despesas_pessoais/app/controllers/ExpensesController.dart';
import 'package:despesas_pessoais/app/controllers/GenericController.dart';
import 'package:despesas_pessoais/app/controllers/UserController.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

final expensesController = Get.put(ExpensesController());
final genericController = Get.put(GenericController());
final userController = Get.put(UserController());

void registerNewUser(BuildContext context) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return Padding(
        padding: EdgeInsets.only(
          //  top: expensesController.heightFull * 0.3,
          left: 20,
          right: 20,
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Card(
          color: Colors.black87,
          child: Container(
            width: expensesController.widthFull * 0.75,
            height: expensesController.heightFull * 0.3,
            child: columnTooManyWidgets(context),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
          ),
        ),
      );
    },
  );
}

columnTooManyWidgets(BuildContext context) {
  return Container(
    // height: expensesController.heightFull * 0.35,
    width: expensesController.widthFull,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        textAppName(context),
        Divider(
          height: 1,
          color: Colors.white,
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: 20,
            right: 20,
          ),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Icon(
                  Icons.person,
                  color: Colors.white,
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: TextField(
                    controller: userController.nameController,
                    decoration: InputDecoration(
                      labelText: 'Nome',
                      labelStyle: TextStyle(color: Colors.white),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                    ),
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ]),
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: 20,
            right: 20,
          ),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Icon(
                  Icons.person,
                  color: Colors.white,
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: TextField(
                    controller: userController.loginController,
                    decoration: InputDecoration(
                      labelText: 'Login',
                      labelStyle: TextStyle(color: Colors.white),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                    ),
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ]),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, bottom: 5),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Icon(
                  Icons.password,
                  color: Colors.white,
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: GetBuilder<ExpensesController>(builder: (_) {
                    return TextField(
                      controller: userController.passwordController,
                      onTap: () {},
                      decoration: InputDecoration(
                        labelText: 'Senha',
                        labelStyle: TextStyle(color: Colors.white),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                      ),
                      obscureText: true,
                      style: TextStyle(color: Colors.white),
                    );
                  }),
                ),
              ]),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, bottom: 5),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Icon(
                  Icons.password,
                  color: Colors.white,
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: GetBuilder<ExpensesController>(builder: (_) {
                    return TextField(
                      controller: userController.confirmPasswordController,
                      onTap: () {},
                      decoration: InputDecoration(
                        labelText: 'Confirmar Senha',
                        labelStyle: TextStyle(color: Colors.white),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                      ),
                      obscureText: true,
                      style: TextStyle(color: Colors.white),
                    );
                  }),
                ),
              ]),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: GetBuilder<UserController>(builder: (_) {
            return _.registeringUser
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(
                          color: Colors.orange,
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          'Registrando usuário...',
                          style: TextStyle(color: Colors.white),
                        )
                      ],
                    ),
                  )
                : Container(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () =>
                          userController.verifyIfEmptyControllerOnRegister(),
                      label: Text(
                        'Registrar',
                        style: TextStyle(color: Colors.black),
                      ),
                      icon: Icon(
                        Icons.login_rounded,
                        color: Colors.black,
                      ),
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.white),
                      ),
                    ),
                  );
          }),
        ),
        SizedBox(
          width: 10,
        ),
        Container(
          width: expensesController.widthFull * 0.45,
          child: TextButton(
            onPressed: () {
              userController.clearControllers();
              Get.back();
            },
            child: Text(
              'Voltar',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget textAppName(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.only(top: 30, bottom: 0),
    child: Container(
      child: Column(
        children: [
          Text(
            'Cadastro de Usuário ',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    ),
  );
}


 /**
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
                                Text('Registrar nova despesa.',
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
                                          expensesController.dateController,
                                      onTap: () => expensesController
                                          .selectDate(context),
                                      decoration: InputDecoration(
                                        labelText: 'Data',
                                      ),
                                    );
                                  }),
                                ),
                              ]),
                        ),
                        GetBuilder<ExpensesController>(builder: (_) {
                          return _.inRegisterExpensesProcess
                              ? Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CircularProgressIndicator(),
                                      Text('Salvando despesa...')
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
                                                label: Text('Registrar'),
                                                icon: Icon(Icons.save),
                                                style: ButtonStyle(
                                                  backgroundColor:
                                                      MaterialStateProperty.all(
                                                          myColorBlack),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Expanded(
                                              child: ElevatedButton.icon(
                                                onPressed: () =>
                                                    expensesController
                                                        .clearControllers(),
                                                label: Text('Nova despesa'),
                                                icon:
                                                    Icon(Icons.fiber_new_sharp),
                                                style: ButtonStyle(
                                                  backgroundColor:
                                                      MaterialStateProperty.all(
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
                                          onPressed: () => Get.back(),
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
   */
