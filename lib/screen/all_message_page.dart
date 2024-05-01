import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/message_controller.dart';
import 'components/message_component.dart';
import '../models/user_model.dart'; // Pour accéder à UserModel

class AllMessagePage extends StatefulWidget {
  final String specialite;
  final UserModel usr; // Ajoutez une référence à UserModel

  const AllMessagePage(
      {super.key, required this.specialite, required this.usr});

  @override
  State<AllMessagePage> createState() => _AllMessagePageState();
}

class _AllMessagePageState extends State<AllMessagePage> {
  final controller = Get.put(MessageController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          flexibleSpace: Center(
            child: Image.asset(
              "assets/logo_title_image.png",
              height: 60,
            ),
          ),
          backgroundColor: Colors.transparent,
        ),
        body: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              Text(
                "All messages",
                style: Theme.of(context).textTheme.headline4!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              SizedBox(height: 10),
              Expanded(
                child: StreamBuilder<List<dynamic>>(
                  stream: controller.getMessageController(widget.specialite),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Text('No data available');
                    } else {
                      return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          final message = snapshot.data![index];

                          return GestureDetector(
                            onLongPress: widget.usr.role == "Admin"
                                ? () {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: Text("Confirm Deletion"),
                                          content: Text(
                                              "Do you really want to delete this message?"),
                                          actions: [
                                            TextButton(
                                              onPressed: () =>
                                                  Navigator.pop(context),
                                              child: Text("Cancel"),
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                controller
                                                    .deleteMessageController(
                                                  widget.specialite,
                                                  message.idMsg,
                                                );
                                                Navigator.pop(
                                                    context); // Ferme le dialogue
                                                setState(
                                                    () {}); // Rafraîchit l'interface utilisateur
                                              },
                                              child: Text("Delete"),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  }
                                : null, // Désactiver l'événement onLongPress si l'utilisateur n'est pas admin
                            child: ListTile(
                              title: MessageComponent(msg: message),
                            ),
                          );
                        },
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
