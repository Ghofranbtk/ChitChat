import 'package:get/get.dart';

import '../models/user_model.dart';
import '../repository/auth_repo.dart';

class AuthController extends GetxController {
  static AuthController get instance => Get.find();
  final _authRepo = Get.put(AuthRepo());

  Future<bool?> createUserController(UserModel user) async {
    bool? status = await _authRepo.SignUp(user.email!, user.password!);
    if (status == true) await _authRepo.createUser(user);
    return status;
  }

  Future<bool?> loginUserController(UserModel user, String role) async {
    return _authRepo.SignIn(user.email!, user.password!, role);
  }

  Future<void> logoutController() async {
    _authRepo.logout();
  }

  getUserDetailsController(String role) async {
    final email = _authRepo.firebaseUser.value?.email;
    if (email != null) {
      return _authRepo.getUserDetails(email, role);
    } else
      return null;
  }

  addSpecialiteToListController(String userId, String element, String role) {
    _authRepo.addSpecialiteToList(userId, element, role);
  }

  Stream<List<dynamic>> getListSpecilityController(String userId, String role) {
    return _authRepo.getListSpecility(userId, role);
  }

  // Ajouter le contrôleur de réinitialisation de mot de passe
  Future<void> forgotPasswordController(String email) async {
    await _authRepo.forgotPassword(email);
  }
}
