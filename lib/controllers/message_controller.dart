import 'package:get/get.dart';

import '../models/message_model.dart';
import '../repository/message_repo.dart';

class MessageController extends GetxController {
  static MessageController get instance => Get.find();
  final _messageRepo = Get.put(MessageRepo());
  createMsgController(MessageModel msg, String specialite, String urlImg) {
    _messageRepo.createMsg(msg, specialite, urlImg);
  }

  Stream<List<dynamic>> getMessageController(String specialite) {
    return _messageRepo.getMessage(specialite);
  }

  // Supprimer un message via le contrôleur
  void deleteMessageController(String specialite, String messageId) {
    _messageRepo.deleteMessage(specialite, messageId);
  }

  // Supprimer une spécialité via le contrôleur
  void deleteSpecialityController(
      String userId, String speciality, String role) {
    _messageRepo.deleteSpeciality(userId, speciality, role);
  }
}
