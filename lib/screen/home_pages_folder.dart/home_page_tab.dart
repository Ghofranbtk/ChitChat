import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:chitchat/screen/add_speciality_page.dart';
import '../../controllers/message_controller.dart';
import '../../controllers/auth_controller.dart';
import '../../models/user_model.dart';
import '../../theme/constants.dart';
import '../components/speciality_component.dart';

class HomePageTab extends StatefulWidget {
  final UserModel usr;

  const HomePageTab({Key? key, required this.usr}) : super(key: key);

  @override
  State<HomePageTab> createState() => _HomePageTabState();
}

class _HomePageTabState extends State<HomePageTab> {
  final authController = Get.put(AuthController());
  final messageController = Get.put(MessageController());

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Specialities",
                style: Theme.of(context).textTheme.headline4!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddSpecialityPage(user: widget.usr),
                    ),
                  );
                },
                child: Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: kBlueColor,
                  ),
                  child: Icon(
                    Icons.add,
                    color: kWhiteColor,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Expanded(
            //activation action en temps réel
            child: StreamBuilder<List<dynamic>>(
              stream: authController.getListSpecilityController(
                  widget.usr.id!, widget.usr.role!),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Text('No data available');
                } else {
                  List<dynamic> listData = snapshot.data!;
                  return ListView.builder(
                    itemCount: listData.length,
                    itemBuilder: (context, index) {
                      var specialite = listData[index];

                      return ListTile(
                        title: SpecialityComponent(
                          specialite: specialite,
                          usr: widget.usr,
                        ),
                        onLongPress: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text("Confirm deletion"),
                                content: Text(
                                  "Do you really want to delete this specialty?",
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text("Exit"),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      messageController
                                          .deleteSpecialityController(
                                        widget.usr.id!,
                                        specialite,
                                        widget.usr.role!,
                                      );
                                      Navigator.pop(context);
                                    },
                                    child: Text("Delete"),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
