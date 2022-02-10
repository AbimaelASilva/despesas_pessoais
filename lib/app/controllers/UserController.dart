import 'package:despesas_pessoais/app/controllers/ExpensesController.dart';
import 'package:despesas_pessoais/app/models/userModel.dart';
import 'package:despesas_pessoais/app/repositories/UserRepositorie.dart';
import 'package:despesas_pessoais/app/views/homeComponentsView/homeView.dart';
import 'package:despesas_pessoais/app/views/login/registerNewUser.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

final expensesController = Get.put(ExpensesController());

class UserController extends GetxController {
  UserModel user = UserModel();
  UserModel logggedUser = UserModel();
  bool userIsValidate = false;
  bool consultingUser = false;
  bool registeringUser = false;

  TextEditingController nameController = TextEditingController();
  TextEditingController loginController = TextEditingController(text: );
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  String idGoogle = '0';

  verifyIfEmptyControllerOnLogin() {
    bool verify =
        (loginController.text.isNotEmpty && passwordController.text.isNotEmpty)
            ? true
            : false;

    if (verify) {
      consultingUser = true;
      update();
      validateUserForLogin();
    } else {
      Get.snackbar('Ops!', 'Preencha o(s) campo(s) vazio(s)!',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.black87,
          colorText: Colors.white);
    }
  }

  validateUserForLogin() async {
    userIsValidate = await UserRepositorie().validateUser(
      UserModel(
        login: loginController.text,
        passwords: passwordController.text,
      ),
    );
    consultingUser = false;
    update();
    if (userIsValidate) {
      iniListAndCallHome();
    } else {
      Get.snackbar('O não!', 'Usuário não identificado/cadastrado',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.black87,
          colorText: Colors.white,
          icon: Icon(
            Icons.error,
            color: Colors.orange,
            size: 35,
          ),
          snackStyle: SnackStyle.FLOATING,
          padding: EdgeInsets.only(left: 50, top: 20, right: 0, bottom: 20));
    }

    update();
  }

  iniListAndCallHome() {
    expensesController.allExpensesList.clear();
    clearControllers();
    expensesController.getAllExpanses();
    Get.to(() => HomeView());
  }

  verifyIfEmptyControllerOnRegister() {
    bool verifyControllersOk = (nameController.text.isNotEmpty &&
            loginController.text.isNotEmpty &&
            passwordController.text.isNotEmpty &&
            confirmPasswordController.text.isNotEmpty)
        ? true
        : false;

    if (verifyControllersOk) {
      if (passwordController.text == confirmPasswordController.text) {
        registeringUser = true;
        update();
        checkIfLoginExists();
      } else {
        registeringUser = false;
        update();
        Get.snackbar('Ops!', 'Senhas digitadas não conferem!',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.black87,
            colorText: Colors.white,
            icon: Icon(
              Icons.error_outline_outlined,
              color: Colors.red,
              size: 35,
            ),
            snackStyle: SnackStyle.FLOATING,
            padding: EdgeInsets.only(left: 50, top: 20, right: 0, bottom: 20));
      }
    } else {
      registeringUser = false;
      update();
      Get.snackbar('Ops!', 'Preencha todos os campos!',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.black87,
          colorText: Colors.white,
          icon: Icon(
            Icons.error_outline_outlined,
            color: Colors.red,
            size: 35,
          ),
          snackStyle: SnackStyle.FLOATING,
          padding: EdgeInsets.only(left: 50, top: 20, right: 0, bottom: 20));
    }
  }

  checkIfLoginExists() async {
    bool loginExists = await UserRepositorie().checkIfLoginExists(
      UserModel(
        name: nameController.text,
        login: loginController.text,
        passwords: passwordController.text,
        idGoogle: idGoogle,
      ),
    );

    if (loginExists) {
      registeringUser = false;
      if (idGoogle != '0') {
        Get.back();
        expensesController.allExpensesList.clear();
        clearControllers();
        expensesController.getAllExpanses();
        Get.to(() => HomeView());
      } else {
        update();

        Get.snackbar(
            'Ops!', 'O Login ( ${loginController.text} ) já está em uso!',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.black87,
            colorText: Colors.white,
            icon: Icon(
              Icons.error_outline_outlined,
              color: Colors.red,
              size: 35,
            ),
            snackStyle: SnackStyle.FLOATING,
            padding: EdgeInsets.only(left: 50, top: 20, right: 0, bottom: 20));
      }
    } else {
      registerNewUser();
    }

    update();
  }

  registerNewUser() async {
    bool userHasBeenSaved = await UserRepositorie().registerNewUser(
      UserModel(
        name: nameController.text,
        login: loginController.text,
        passwords: passwordController.text,
        idGoogle: idGoogle,
      ),
    );
    registeringUser = false;
    update();
    if (userHasBeenSaved) {
      Get.back();
      if (idGoogle != '0') {
        Get.back();
        Get.to(() => HomeView());
      }

      Get.snackbar('O Usuário(${nameController.text}) foi registrado!',
          'Você já pode logar no app!',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.black87,
          colorText: Colors.white,
          icon: Icon(
            Icons.check_circle_outline,
            color: Colors.orange,
            size: 35,
          ),
          snackStyle: SnackStyle.FLOATING,
          padding: EdgeInsets.only(left: 50, top: 20, right: 0, bottom: 20));
      clearControllers();
    } else {
      Get.snackbar('O não!', 'Erro ao salvar usuário!!',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.black87,
          colorText: Colors.white,
          icon: Icon(
            Icons.error,
            color: Colors.red,
            size: 35,
          ),
          snackStyle: SnackStyle.FLOATING,
          padding: EdgeInsets.only(left: 50, top: 20, right: 0, bottom: 20));
    }

    update();
  }

  clearControllers() {
    nameController.clear();
    loginController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
    update();
  }
}
