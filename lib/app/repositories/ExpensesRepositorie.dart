import 'package:despesas_pessoais/app/constants/constants.dart';
import 'package:despesas_pessoais/app/controllers/UserController.dart';
import 'package:despesas_pessoais/app/models/ExpensesModel.dart';
import 'package:get/get.dart';
import 'package:hasura_connect/hasura_connect.dart';

final userController = Get.put(UserController());

class ExpensesRepositorie {
  HasuraConnect _hasuraConnect = myConfigHasuraConnect();

  Future<List<ExpensesModel>> getAllExpanses() async {
    String query = """
            query MyQuery {
              personal_expenses(
                where: {
                  idUser: {_eq: ${userController.logggedUser.id}}
                }
              ) {
                id
                idUser
                title
                value
                date
              }
            }
            """;

    var returnGetAllExpanses = await _hasuraConnect.query(query);

   // print('CONSULTA DAS DESPESAS: $returnGetAllExpanses');
    List<ExpensesModel> expensesModelList = [];
    returnGetAllExpanses['data']['personal_expenses'].forEach((expenses) {
      //print('CONSULTA DAS DESPESAS NO FOR: $expenses');
      expensesModelList.add(ExpensesModel.fromJson(expenses));
    });

    return expensesModelList;
  }

  Future<bool> registerNewExpense(
      ExpensesModel expenseEnteredInTheControls) async {
    print('AJUSTAR ID DO USUÁRIO PARA DESPESA');
    String myMutation = """
           mutation MyMutation {
              insert_personal_expenses(
                objects: {
                  idUser: ${userController.logggedUser.id},
                  title: "${expenseEnteredInTheControls.title}", 
                  value: ${expenseEnteredInTheControls.value}, 
                  date: "${expenseEnteredInTheControls.date}"
                  }) {
                affected_rows
              }
            }
            """;
    var returnRegisterNewExpense = await _hasuraConnect.mutation(myMutation);

    // print('CONSULTA DAS DESPESAS: $returnGetAllExpanses');

    if (returnRegisterNewExpense['data']['insert_personal_expenses']
            ['affected_rows'] ==
        0) {
      return false;
    } else {
      return true;
    }
  }

  Future<bool> updateExpense(ExpensesModel expenseEnteredInTheControls) async {
    print('ATUALIZANDO DESPESA');
    String myMutation = """
            mutation MyMutation {
              update_personal_expenses(
                where: {
                  id: {_eq: ${expenseEnteredInTheControls.id}}}, 
                _set: {
                  title: "${expenseEnteredInTheControls.title}", 
                  value: ${expenseEnteredInTheControls.value}, 
                  date: "${expenseEnteredInTheControls.date}"
                }) {
                affected_rows
              }
            }
            """;

    print('ATUALIZANDO DESPESA: $myMutation');
    var returnRegisterNewExpense = await _hasuraConnect.mutation(myMutation);

    // print('CONSULTA DAS DESPESAS: $returnGetAllExpanses');

    if (returnRegisterNewExpense['data']['update_personal_expenses']
            ['affected_rows'] ==
        0) {
      return false;
    } else {
      return true;
    }
  }
}
