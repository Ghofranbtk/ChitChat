import 'package:flutter/material.dart';

import '../models/message_model.dart';
import '../theme/constants.dart';

class MessagePage extends StatelessWidget {
  const MessagePage({super.key, this.msg});
  final MessageModel? msg;

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
              Expanded(
                flex: 2,
                child: Image.network(
                  msg!.urlImg.toString(),
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),
              SizedBox(height: 10),
              Expanded(
                  flex: 1,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        RichText(
                          textAlign: TextAlign.start,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          text: TextSpan(
                            style: Theme.of(context).textTheme.headline6!,
                            children: <TextSpan>[
                              TextSpan(
                                text: "Title : ",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: kBlueColor,
                                ),
                              ),
                              TextSpan(
                                text: msg!.title.toString(),
                                style: TextStyle(),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10),
                        RichText(
                          textAlign: TextAlign.start,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          text: TextSpan(
                            style: Theme.of(context).textTheme.headline6!,
                            children: <TextSpan>[
                              TextSpan(
                                text: "Prof : ",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: kBlueColor,
                                ),
                              ),
                              TextSpan(
                                text: msg!.nomProf.toString(),
                                style: TextStyle(),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10),
                        RichText(
                          textAlign: TextAlign.start,
                          maxLines: 5,
                          overflow: TextOverflow.ellipsis,
                          text: TextSpan(
                            style: Theme.of(context).textTheme.headline6!,
                            children: <TextSpan>[
                              TextSpan(
                                text: "Description : ",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: kBlueColor,
                                ),
                              ),
                              TextSpan(
                                text: msg!.description.toString(),
                                style: TextStyle(),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
