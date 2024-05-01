import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../../models/user_model.dart';
import '../../theme/constants.dart';
import '../all_message_page.dart';

class SpecialityComponent extends StatelessWidget {
  final String specialite;
  final UserModel
      usr; // Vous avez besoin de cette variable pour le constructeur

  const SpecialityComponent({
    super.key,
    required this.specialite,
    required this.usr,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AllMessagePage(
              specialite: specialite,
              usr: usr, // Passez l'utilisateur ici
            ),
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.grey.withOpacity(0.2),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundImage: AssetImage("assets/categorys.png"),
              radius: 25,
            ),
            SizedBox(width: 10),
            Expanded(
              child: RichText(
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
                      text: specialite,
                      style: TextStyle(),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
