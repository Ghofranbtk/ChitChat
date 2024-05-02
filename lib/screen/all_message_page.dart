import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/message_controller.dart';
import 'components/message_component.dart';
import '../models/user_model.dart'; // Pour accéder à UserModel
import 'package:chitchat/screen/update_message_page.dart';

class AllMessagePage extends StatefulWidget {
  final String specialite;
  final UserModel usr; // Référence à UserModel

  const AllMessagePage({
    super.key,
    required this.specialite,
    required this.usr,
  });

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
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Text(
                "All messages",
                style: Theme.of(context).textTheme.headline4!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: StreamBuilder<List<dynamic>>(
                  stream: controller.getMessageController(widget.specialite),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Text('No data available');
                    } else {
                      return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          final message = snapshot.data![index];

                          return GestureDetector(
                            onLongPress: () {
                              if (widget.usr.role == "Admin") {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: const Text("Choose an action"),
                                      content: const Text(
                                        "What do you want to do with this message?",
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            controller.deleteMessageController(
                                              widget.specialite,
                                              message.idMsg,
                                            );
                                            Navigator.pop(
                                                context); // Ferme le dialogue
                                            setState(
                                                () {}); // Rafraîchit l'interface utilisateur
                                          },
                                          child: const Text("Delete"),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    UpdateMessagePage(
                                                  specialite: widget.specialite,
                                                  message: message,
                                                ),
                                              ),
                                            ); // Navigue vers la page de mise à jour
                                          },
                                          child: const Text("Update"),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              }
                            },
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
