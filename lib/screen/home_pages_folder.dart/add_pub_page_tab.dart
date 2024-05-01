import 'dart:io';

import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../controllers/message_controller.dart';
import '../../models/message_model.dart';
import '../../models/user_model.dart';
import '../../theme/constants.dart';

class AddPubPageTab extends StatefulWidget {
  const AddPubPageTab({super.key, required this.usr});
  final UserModel usr;

  @override
  State<AddPubPageTab> createState() => _AddPubPageTabState();
}

class _AddPubPageTabState extends State<AddPubPageTab> {
  TextEditingController _titreController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  bool _isChecked = false;
  File? _image;
  final picker = ImagePicker();
  Future getImageGallery() async {
    final pickedFile =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 80);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print("no image picked");
      }
    });
  }

  List<String> specialite = [
    '1ING',
    '2ING',
    '3ING',
    '1IDL1',
    '1IDL2',
    '2IDL1',
    '2IDL2',
    'Lce1',
    'Lce2',
    'MDL',
    'SSII',
    'SIIOT',
  ];
  String? selectedSpecialite = '1ING';

  final controller = Get.put(MessageController());

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(10),
        child: Form(
          key: formkey,
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Text(
                        "Add a new message",
                        style: Theme.of(context)
                            .textTheme
                            .headline3!
                            .copyWith(fontWeight: FontWeight.bold),
                        textAlign: TextAlign.start,
                      ),
                      SizedBox(height: 10),
                      Center(
                        child: InkWell(
                          onTap: () {
                            getImageGallery();
                          },
                          child: Container(
                            height: 200,
                            width: 300,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.grey.withOpacity(0.5)),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: _image != null
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(5),
                                    child: Image.file(
                                      _image!.absolute,
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                : Center(
                                    child: Icon(
                                        Icons.add_photo_alternate_outlined,
                                        size: 30),
                                  ),
                          ),
                        ),
                      ),
                      //
                      SizedBox(height: 20),
                      DropdownButton<String>(
                        value: selectedSpecialite,
                        items: specialite
                            .map(
                              (item) => DropdownMenuItem<String>(
                                  value: item, child: Text(item)),
                            )
                            .toList(),
                        onChanged: (item) => setState(() {
                          selectedSpecialite = item;
                        }),
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        controller: _titreController,
                        maxLines: 1,
                        decoration: InputDecoration(
                          hintText: "Title",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        style:
                            Theme.of(context).inputDecorationTheme.labelStyle,
                        validator: MultiValidator(
                          [
                            RequiredValidator(errorText: "*Required"),
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        controller: _descriptionController,
                        maxLines: 4,
                        decoration: InputDecoration(
                          hintText: "Description",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        style:
                            Theme.of(context).inputDecorationTheme.labelStyle,
                        validator: MultiValidator(
                          [
                            RequiredValidator(errorText: "*Required"),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10),
              Positioned(
                bottom: 20,
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(double.infinity, 50),
                      backgroundColor: kBlueColor,
                    ),
                    onPressed: () async {
                      if (formkey.currentState!.validate()) {
                        final msg = MessageModel(
                          title: _titreController.text.trim(),
                          description: _descriptionController.text.trim(),
                          nomProf: widget.usr.fullName,
                        );
                        await controller.createMsgController(
                            msg, selectedSpecialite!, _image!.path);
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("The message is sended")));
                      }
                    },
                    child: Text(
                      "Send",
                      style: Theme.of(context).textTheme.headline4!.copyWith(
                            color: kWhiteColor,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ));
  }
}
