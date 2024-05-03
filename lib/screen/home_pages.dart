import 'package:chitchat/screen/home_pages_folder.dart/add_pub_page_tab.dart';
import 'package:chitchat/screen/home_pages_folder.dart/home_page_tab.dart';
import 'package:chitchat/screen/home_pages_folder.dart/profil_page_tab.dart';
import 'package:flutter/material.dart';

import '../models/user_model.dart';
import '../theme/constants.dart';

class HomePages extends StatelessWidget {
  const HomePages({super.key, required this.usr});
  final UserModel usr;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 3,
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
          body: Column(
            children: [
              TabBar(
                tabs: [
                  Tab(
                    icon: Icon(
                      Icons.home,
                      color: kDarkBlueColor,
                    ),
                  ),
                  usr.role == "Admin"
                      ? Tab(
                          icon: Icon(
                            Icons.add_comment_outlined,
                            color: kDarkBlueColor,
                          ),
                        )
                      : Container(),
                  Tab(
                    icon: Icon(
                      Icons.person,
                      color: kDarkBlueColor,
                    ),
                  ),
                ],
              ),
              Expanded(
                child: TabBarView(children: [
                  HomePageTab(usr: usr),
                  usr.role == "Admin" ? AddPubPageTab(usr: usr) : Container(),
                  ProfilPageTab(usr: usr),
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
