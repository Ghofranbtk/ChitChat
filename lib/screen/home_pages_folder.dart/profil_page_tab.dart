import 'package:chitchat/screen/signin_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/auth_controller.dart';
import '../../models/user_model.dart';
import '../../theme/constants.dart';

class ProfilPageTab extends StatefulWidget {
  const ProfilPageTab({super.key, required this.usr});
  final UserModel usr;

  @override
  State<ProfilPageTab> createState() => _ProfilPageTabState();
}

class _ProfilPageTabState extends State<ProfilPageTab> {
  final controller = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(500),
            child: Image.asset(
              "assets/person_image.png",
              height: 100,
            ),
          ),
          SizedBox(height: 10),
          Text(
            widget.usr.fullName!,
            style: Theme.of(context).textTheme.headline3!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
            textAlign: TextAlign.start,
          ),
          Spacer(),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
                backgroundColor: kBlueColor,
              ),
              onPressed: () async {
                controller.logoutController().then(
                      (value) => Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SigninPage(),
                        ),
                      ),
                    );
              },
              child: Text(
                "Logout",
                style: Theme.of(context).textTheme.headline4!.copyWith(
                      color: kWhiteColor,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
