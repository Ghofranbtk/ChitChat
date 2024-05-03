import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../models/user_model.dart';

class AuthRepo extends GetxController {
  // Création d'une instance singleton du dépôt pour l'utilisation avec GetX
  static AuthRepo get instance => Get.find();

  final _db = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  // Variable réactive pour suivre l'utilisateur Firebase
  late final Rx<User?> firebaseUser;

  // Variable observable pour stocker l'identifiant de vérification lors de l'authentification
  var verificationId = ''.obs;

  @override
  void onReady() {
    // Initialisation de la variable réactive avec l'utilisateur Firebase actuel
    firebaseUser = Rx<User?>(_auth.currentUser);
    firebaseUser.bindStream(_auth.userChanges());
  }

  // Créer un utilisateur Firestore
  createUser(UserModel user) async {
    final docUser = _db
        .collection(user.role!)
        .doc(); // Créer un document Firestore basé sur le rôle de l'utilisateur
    user =
        user.setId(docUser.id); // Mettre à jour l'utilisateur avec l'ID généré
    await docUser.set(user
        .toJson()); // Enregistrer l'utilisateur dans Firestore sous forme JSON
  }

  // Obtenir les détails d'un utilisateur à partir de Firestore
  Future<UserModel> getUserDetails(String email, String role) async {
    final snapshot = await _db
        .collection(role)
        .where("email", isEqualTo: email) // Rechercher l'utilisateur par email
        .get(); // Obtenir le résultat de la requête
    final userData = snapshot.docs
        .map((e) => UserModel.fromSnapshot(
            e)) // Convertir les documents en objets UserModel
        .single; // Récupérer le seul utilisateur correspondant

    return userData; // Retourner les détails de l'utilisateur
  }

  // Inscription d'un utilisateur avec Firebase Auth
  Future<bool?> SignUp(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email,
          password:
              password); // Créer un utilisateur avec email et mot de passe
      return true; // Retourner true si l'inscription réussit
    } on FirebaseAuthException catch (e) {
      return false; // Retourner false en cas d'exception d'authentification
    }
  }

  // Connexion d'un utilisateur avec Firebase Auth
  Future<bool?> SignIn(String email, String password, String role) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      UserModel usr = await getUserDetails(
          email, role); // Obtenir les détails de l'utilisateur
      if (usr.role == role) // Vérifier si le rôle de l'utilisateur correspond
        return true;
      else
        return false;
    } on FirebaseAuthException catch (e) {
      return false;
    }
  }

  // Déconnexion user
  Future<void> logout() async =>
      await _auth.signOut(); // Déconnecter l'utilisateur

  // Ajouter une spécialité à la liste de l'utilisateur
  Future<void> addSpecialiteToList(
      String userId, String element, String role) async {
    try {
      final docRef = _db
          .collection(role)
          .doc(userId); // Obtenir la référence du document Firestore
      await docRef.update({
        "listSpecialite": FieldValue.arrayUnion(
            [element]), // Ajouter un élément à une liste dans Firestore
      });
    } catch (e) {
      print("Erreur lors de l'ajout de l'élément à la liste : $e");
      throw e;
    }
  }

  // Obtenir une liste de spécialités de user
  Stream<List<dynamic>> getListSpecility(String userId, String role) {
    return _db.collection(role).doc(userId).snapshots().map((docSnapshot) {
      if (docSnapshot.exists) {
        return List<dynamic>.from(docSnapshot.data()![
            "listSpecialite"]); // Convertir le tableau de spécialités en liste
      } else {
        return [];
      }
    });
  }

  // Forgot password
  Future<void> forgotPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(
          email: email); // Envoyer un email de réinitialisation de mot de passe
    } catch (e) {
      throw e;
    }
  }
}
