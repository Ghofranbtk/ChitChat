import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  final String? title;
  final String? description;
  final String? idMsg;
  final String? nomProf;
  final String? urlImg;

  MessageModel({
    this.title,
    this.description,
    this.idMsg,
    this.nomProf,
    this.urlImg,
  });
  MessageModel setIdandUrlMsg(String IdMsg, urlMsg) {
    return MessageModel(
      idMsg: IdMsg,
      title: this.title,
      description: this.description,
      nomProf: this.nomProf,
      urlImg: urlMsg,
    );
  }

  factory MessageModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return MessageModel(
      title: data["title"],
      description: data["description"],
      idMsg: data["idMsg"],
      nomProf: data["nomProf"],
      urlImg: data["urlImg"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "description": description,
      "idMsg": idMsg,
      "nomProf": nomProf,
      "urlImg": urlImg,
    };
  }
}
