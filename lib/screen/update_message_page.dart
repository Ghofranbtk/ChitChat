import 'dart:io';

import 'package:chitchat/controllers/message_controller.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:image_picker/image_picker.dart';
import '../../models/message_model.dart';
import '../../theme/constants.dart';
import 'package:http/http.dart' as http;

const String backendUrl = 'http://10.10.2.95:9250/api/updatedNotification';

//nodemon
class UpdateMessagePage extends StatefulWidget {
  final MessageModel message;
  final String specialite; // Ajouter la spécialité

  const UpdateMessagePage({
    super.key,
    required this.message,
    required this.specialite, // Assurer que la spécialité est reçue
  });

  @override
  State<UpdateMessagePage> createState() => _UpdateMessagePageState();
}

class _UpdateMessagePageState extends State<UpdateMessagePage> {
  late TextEditingController _titreController;
  late TextEditingController _descriptionController;
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  File? _image;
  final picker = ImagePicker();

  Future<void> triggerNotification() async {
    try {
      final response = await http.get(Uri.parse(backendUrl));

      if (response.statusCode == 200) {
        print("Notification envoyée aux étudiants.");
      } else {
        print(
            "Erreur lors de l'envoi de la notification: ${response.statusCode}");
      }
    } catch (error) {
      print("Erreur: $error");
    }
  }

  @override
  void initState() {
    super.initState();
    _titreController = TextEditingController(
      text: widget.message.title,
    ); // Initialiser le titre
    _descriptionController = TextEditingController(
      text: widget.message.description,
    ); // Initialiser la description
  }

  Future getImageGallery() async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print("No image picked");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Update Message"), // Titre de la page
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Form(
          key: formkey,
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Text(
                        "Update the message",
                        style: Theme.of(context).textTheme.headline4!.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      const SizedBox(height: 10),
                      Center(
                        child: InkWell(
                          onTap: getImageGallery,
                          child: Container(
                            height: 200,
                            width: 300,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey.withOpacity(0.5),
                              ),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: _image != null
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(5),
                                    child: Image.file(
                                      _image!,
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                : widget.message.urlImg != null
                                    ? ClipRRect(
                                        borderRadius: BorderRadius.circular(5),
                                        child: Image.network(
                                          widget.message.urlImg!,
                                          fit: BoxFit.cover,
                                        ),
                                      )
                                    : const Center(
                                        child: Icon(
                                          Icons.add_photo_alternate_outlined,
                                          size: 30,
                                        ),
                                      ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _titreController,
                        decoration: InputDecoration(
                          hintText: "Title",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        validator: RequiredValidator(
                          errorText: "Title is required",
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: _descriptionController,
                        decoration: InputDecoration(
                          hintText: "Description",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        maxLines: 4,
                        validator: RequiredValidator(
                          errorText: "Description is required",
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                  backgroundColor: kBlueColor,
                ),
                onPressed: () async {
                  if (formkey.currentState!.validate()) {
                    final updatedMessage = MessageModel(
                      idMsg: widget.message.idMsg,
                      title: _titreController.text.trim(),
                      nomProf: widget.message.nomProf,
                      description: _descriptionController.text.trim(),
                      urlImg:
                          _image != null ? _image!.path : widget.message.urlImg,
                    );
                    await triggerNotification();
                    MessageController.instance.editMessageController(
                      widget.specialite,
                      updatedMessage,
                    );

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Message updated successfully"),
                      ),
                    );

                    Navigator.pop(context); // Retour à la page précédente
                  }
                },
                child: Text(
                  "Update",
                  style: Theme.of(context).textTheme.headline4!.copyWith(
                        color: kWhiteColor,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
