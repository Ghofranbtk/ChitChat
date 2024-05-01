import 'package:chitchat/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';
import '../theme/constants.dart';

class AddSpecialityPage extends StatelessWidget {
  const AddSpecialityPage({super.key, required this.user});
  final UserModel user;

  @override
  Widget build(BuildContext context) {
    List<String> specialite = [
      '1ING',
      '2ING',
      '3ING',
      '1IDL1',
      '1IDL2',
      '2IDL1',
      '2IDL2',
      'LCE1',
      'LCE2',
    ];

    final controller = Get.put(AuthController());

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
                "Select Speciality To Add",
                style: Theme.of(context)
                    .textTheme
                    .headline3!
                    .copyWith(fontWeight: FontWeight.bold),
                textAlign: TextAlign.start,
              ),
              SizedBox(height: 10),
              Expanded(
                child: ListView.builder(
                  itemCount: specialite.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () async {
                        await controller.addSpecialiteToListController(
                          user.id!,
                          specialite[index],
                          user.role!,
                        );
                        Navigator.pop(context);
                      },
                      child: Container(
                        padding: EdgeInsets.all(10),
                        margin: EdgeInsets.symmetric(
                            vertical: 10), // Marges entre les éléments
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.grey.withOpacity(0.2),
                        ),
                        child: Row(
                          // Utilisation de Row pour chaque élément
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              backgroundImage: AssetImage(
                                  "assets/isi_image.png"), // Image circulaire
                              radius: 30, // Ajustez la taille du cercle
                            ),
                            SizedBox(
                                width:
                                    20), // Espacement entre l'image et le texte
                            RichText(
                              textAlign: TextAlign.start,
                              text: TextSpan(
                                style: Theme.of(context).textTheme.headline6!,
                                children: <TextSpan>[
                                  TextSpan(
                                    text: "Speciality: ",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: kBlueColor,
                                    ),
                                  ),
                                  TextSpan(
                                    text: specialite[index],
                                    style: TextStyle(),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
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
