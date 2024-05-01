import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../models/user_model.dart';

class AuthRepo extends GetxController {
  static AuthRepo get instance => Get.find();
  final _db = FirebaseFirestore.instance;
  //Variables
  final _auth = FirebaseAuth.instance;
  late final Rx<User?> firebaseUser;
  var verificationId = ''.obs;

  @override
  void onReady() {
    firebaseUser = Rx<User?>(_auth.currentUser);
    firebaseUser.bindStream(_auth.userChanges());
  }

  //Create a user
  createUser(UserModel user) async {
    final docUser = _db.collection(user.role!).doc();
    user = user.setId(docUser.id);
    await docUser.set(user.toJson());
  }

  //Get User
  Future<UserModel> getUserDetails(String email, String role) async {
    final snapshot =
        await _db.collection(role).where("email", isEqualTo: email).get();
    final userData = snapshot.docs.map((e) => UserModel.fromSnapshot(e)).single;

    return userData;
  }

//Sign Up
  Future<bool?> SignUp(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return true;
    } on FirebaseAuthException catch (e) {
      return false;
    }
  }
  //Sign In

  Future<bool?> SignIn(String email, String password, String role) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      UserModel usr = await getUserDetails(email, role);
      if (usr.role == role)
        return true;
      else
        return false;
    } on FirebaseAuthException catch (e) {
      return false;
    }
  }

  //Logout
  Future<void> logout() async => await _auth.signOut();

  //Add speciality to list
  Future<void> addSpecialiteToList(
      String userId, String element, String role) async {
    try {
      final docRef = _db.collection(role).doc(userId);
      await docRef.update({
        "listSpecialite": FieldValue.arrayUnion([element]),
      });
    } catch (e) {
      print("Erreur lors de l'ajout de l'élément à la liste : $e");
      throw e;
    }
  }

  // get list of speciality
  Stream<List<dynamic>> getListSpecility(String userId, String role) {
    return _db.collection(role).doc(userId).snapshots().map((docSnapshot) {
      if (docSnapshot.exists) {
        return List<dynamic>.from(docSnapshot.data()!["listSpecialite"]);
      } else {
        return [];
      }
    });
  }

  // Réinitialisation de mot de passe
  Future<void> forgotPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      throw e; // Renvoyer l'erreur pour un traitement ultérieur
    }
  }
}
