import 'package:despesas_pessoais/app/controllers/UserController.dart';
import 'package:despesas_pessoais/app/models/userModel.dart';
import 'package:despesas_pessoais/app/views/homeComponentsView/homeView.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
//import 'package:google_sign_in/google_sign_in.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:google_sign_in/google_sign_in.dart';

final userController = Get.put(UserController());
Future<UserCredential> signInWithGoogle() async {
  await GoogleSignIn().signOut();
  // Trigger the authentication flow
  final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

  if (googleUser!.id.isNotEmpty) {
    userController.nameController.text = googleUser.displayName!;
    userController.loginController.text = googleUser.email;
    userController.passwordController.text = googleUser.id.toString();
    userController.idGoogle = googleUser.id.toString();

    userController.checkIfLoginExists();
  }

  print('DADOS DO USUÁRIO NO GOOGLE(googleUser): $googleUser');
  // Obtain the auth details from the request
  final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

  // Create a new credential
  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth.accessToken,
    idToken: googleAuth.idToken,
  );

//print('DADOS DO USUÁRIO NO GOOGLE(googleUser): ${googleUser.displayName}');
  // Once signed in, return the UserCredential
  return await FirebaseAuth.instance.signInWithCredential(credential);
}
