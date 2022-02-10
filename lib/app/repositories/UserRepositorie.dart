import 'package:despesas_pessoais/app/constants/constants.dart';
import 'package:despesas_pessoais/app/controllers/UserController.dart';
import 'package:despesas_pessoais/app/models/ExpensesModel.dart';
import 'package:despesas_pessoais/app/models/userModel.dart';
import 'package:get/get.dart';
import 'package:hasura_connect/hasura_connect.dart';

class UserRepositorie {
  HasuraConnect _hasuraConnect = myConfigHasuraConnect();
  final userController = Get.put(UserController());

  Future<bool> validateUser(UserModel user) async {
    String query = """
            query MyQuery {
              user(where: {
                login: {_eq: "${user.login}"}, 
                passwords: {_eq: "${user.passwords}"}
              }) {
                id
                name
                login
                passwords
                created_at
                updated_at
              }
            }

            """;

    var returnGetUser = await _hasuraConnect.query(query);
    print('CONSULTA USUÁRIO : $returnGetUser');

    if (returnGetUser['data']['user'].toString() == '[]') {
      return false;
    } else {
      userController.logggedUser =
          UserModel.fromJson(returnGetUser['data']['user'][0]);
      return true;
    }
  }

  Future<bool> checkIfLoginExists(UserModel user) async {
    String query = """
            query MyQuery {
              user(where: {login: {_like: "${user.login}"}}) {
                id
                idGoogle
                login
                name
                created_at 
                updated_at
              }
            }
            """;
    var returnCheckIfLoginExists = await _hasuraConnect.query(query);
    print('CONSULTA SE USUÁRIO EXISTE: $returnCheckIfLoginExists');

    if (returnCheckIfLoginExists['data']['user'].toString() != '[]') {
      userController.logggedUser = UserModel.fromJson(
          returnCheckIfLoginExists['data']['user'][0]);
      return true;
    } else {
      return false;
    }
  }

  Future<bool> registerNewUser(UserModel user) async {
    print('ANTES DA registro DO USUÁRIO');
    String myMutation = """
          mutation MyMutation {
            insert_user(
                objects: {
                  idGoogle: "${user.idGoogle}", 
                  name: "${user.name}", 
                  login: "${user.login}", 
                  passwords: "${user.passwords}", 
                  updated_at: "${DateTime.now()}", 
                  created_at: "${DateTime.now()}"
                  }) {
                  returning {
                    id
                    idGoogle
                    login
                    name
                    created_at 
                    updated_at
                 }
            }
          }
            """;
    print('registro DO USUÁRIO: $myMutation');
    var returnRegisterNewUser = await _hasuraConnect.mutation(myMutation);

    print('CONSULTA DO USUÁRIO: $returnRegisterNewUser');

    if (returnRegisterNewUser['data']['insert_user']['returning'].toString() !=
        '[]') {
      userController.logggedUser = UserModel.fromJson(
          returnRegisterNewUser['data']['insert_user']['returning'][0]);

          print('ADICIONOU O USUÁRIO');
      return true;
    } else {
      return false;
    }
  }
}
