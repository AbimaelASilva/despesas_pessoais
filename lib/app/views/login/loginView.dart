import 'package:despesas_pessoais/app/controllers/ExpensesController.dart';
import 'package:despesas_pessoais/app/controllers/GenericController.dart';
import 'package:despesas_pessoais/app/controllers/UserController.dart';
import 'package:despesas_pessoais/app/repositories/AuthRepository%20.dart';
import 'package:despesas_pessoais/app/views/login/registerNewUser.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
//import '/presentation/custom_icons_icons.dart'
import 'package:despesas_pessoais/custom/icons/google_icon.dart' as GoogleIcon;

class LoginView extends StatelessWidget {
  final expensesController = Get.put(ExpensesController());
  final genericController = Get.put(GenericController());
  final userController = Get.put(UserController());
  // final myBlackColor = Color.fromRGBO(36, 38, 38, 1);
  // final myOrangeColor = Color(0xAAD89216);
  @override
  Widget build(BuildContext context) {
    setHeightAndWidht(context);
    return Scaffold(
        body: SingleChildScrollView(
      child: Stack(
        children: [
          backGroundImage(context),
          myBody(context),
        ],
      ),
    ));
  }

  Widget myBody(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 50),
      child: Container(
        width: expensesController.widthFull,
        height: expensesController.heightFull,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            logo(context),
            loginCard(context),
          ],
        ),
      ),
    );
  }

  Widget loginCard(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 0),
      child: Card(
        color: genericController.myBlackColor,
        child: Container(
          width: expensesController.widthFull * 0.75,
          height: expensesController.heightFull * 0.60,
          child: columnTooManyWidgets(context),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
        ),
      ),
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
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: GetBuilder<UserController>(builder: (_) {
              return _.consultingUser
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            'Validando usuário..',
                            style: TextStyle(color: Colors.white),
                          )
                        ],
                      ),
                    )
                  : Container(
                      width: double.infinity,
                      child: Row(
                        children: [
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: () => userController
                                  .verifyIfEmptyControllerOnLogin(),
                              label: Text(
                                'Logar',
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
                          ),
                          SizedBox(width: 8,),
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: () => signInWithGoogle(),
                              label: Text(
                                'Acessar com Google',
                            style: TextStyle(
                                  fontSize:
                                      expensesController.widthFull * 0.01,
                                  color: Colors.orange,
                                ),
                              ),
                              icon: Icon(
                                GoogleIcon.GoogleIcon.google,
                                color: Colors.orange,
                              ),
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.white),
                              ),
                            ),
                          ),
                    
                        ],
                      ),
                    );
            }),
          ),
          SizedBox(
            width: 10,
          ),
          SizedBox(
            width: 10,
          ),
          Container(
            width: expensesController.widthFull * 0.45,
            child: TextButton(
              onPressed: () {
                userController.registeringUser = false;
                registerNewUser(context);
              },
              child: Text(
                'Criar conta',
                style: TextStyle(color: Colors.orange),
              ),
            ),
          ),
          Container(
            width: expensesController.widthFull * 0.45,
            child: TextButton(
              onPressed: () {},
              child: Text(
                'Esqueci a senha',
                style: TextStyle(color: Color(0xAAE1D89F)),
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
              'GERENCIADOR DE\n DESPESAS PESSOAIS',
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

  Widget logo(BuildContext context) {
    return SizedBox(
      width: expensesController.widthFull,
      height: expensesController.heightFull * 0.15,
      child: Image.asset('assets/images/logo.png'),
    );
  }

  Widget backGroundImage(context) {
    return Container(
      decoration: BoxDecoration(
        color: genericController.myOrangeColor,
        /* image: DecorationImage(
          //  colorFilter: ColorFilter.mode(Colors.red, BlendMode.color),
          image: AssetImage('assets/images/bg.png'),
          fit: BoxFit.fill,
        ),
        */
        // color: const Color(0xFF0E3311).withOpacity(0.6),
      ),
      height: expensesController.heightFull,
      width: expensesController.widthFull,
    );
  }

  setHeightAndWidht(BuildContext context) {
    expensesController.heightFull = MediaQuery.of(context).size.height;
    expensesController.widthFull = MediaQuery.of(context).size.height;
  }
}
