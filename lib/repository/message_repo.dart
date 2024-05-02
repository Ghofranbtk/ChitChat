import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import '../models/message_model.dart';

class MessageRepo extends GetxController {
  static MessageRepo get instance => Get.find();
  final _db = FirebaseFirestore.instance;

// Créer un message dans Firestore avec une image stockée dans Firebase Storage
  createMsg(MessageModel msg, String specialite, String urlImg) async {
    String msgUrl; // Variable pour stocker l'URL de l'image
    try {
      // creation file dans ce temps
      String fileName = DateTime.now().microsecondsSinceEpoch.toString();

      //creation image fi wost folder imagesmessafe
      Reference referenceRoot = FirebaseStorage.instance.ref();
      Reference referenceDirImages = referenceRoot.child('imagesMessage');
      Reference referenceImageUpload =
          referenceDirImages.child(fileName + ".png");
      await referenceImageUpload.putFile(File(urlImg));

      msgUrl = await referenceImageUpload.getDownloadURL();
      final docMsg = _db.collection(specialite).doc();

      // maj le message id et image
      msg = msg.setIdandUrlMsg(docMsg.id, msgUrl);

      // Enregistrer le message sous forme  JSON
      await docMsg.set(msg.toJson());
    } catch (error) {
      print(error);
    }
  }

// get message
  Stream<List<MessageModel>> getMessage(String specialite) {
    return _db
        .collection(specialite) // Sélectionner la collection specialite
        .snapshots()
        .map((QuerySnapshot<Map<String, dynamic>> docSnapshot) {
      //
      if (docSnapshot.docs.isNotEmpty) {
        return docSnapshot.docs
            .map((doc) => MessageModel.fromSnapshot(
                doc)) // Convertir chaque document en `MessageModel`
            .toList();
      } else {
        return [];
      }
    });
  }

  // Supprimer un message par ID
  Future<void> deleteMessage(String specialite, String messageId) async {
    try {
      await _db.collection(specialite).doc(messageId).delete();
    } catch (error) {
      print(error);
    }
  }

// update message
  Future<void> editMessage(String specialite, MessageModel updatedMsg) async {
    try {
      // Mettre à jour le message existant avec le contenu du message mis à jour
      await _db
          .collection(specialite)
          .doc(updatedMsg.idMsg)
          .update(updatedMsg.toJson());
    } catch (error) {
      print("Erreur lors de la mise à jour du message : $error");
    }
  }

  // Supprimer une spécialité d'un utilisateur dans Firestore
  Future<void> deleteSpeciality(
      String userId, String speciality, String role) async {
    try {
      final userRef = _db.collection(role).doc(userId);
      await userRef.update({
        'listSpecialite': FieldValue.arrayRemove(
            [speciality]), // Retirer la spécialité de la liste
      });
    } catch (error) {
      print(error);
    }
  }
}
