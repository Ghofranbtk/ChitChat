import 'package:flutter/material.dart';
import '../../models/message_model.dart';
import '../../theme/constants.dart';
import '../message_page.dart';

class MessageComponent extends StatelessWidget {
  const MessageComponent({super.key, required this.msg});
  final MessageModel msg;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MessagePage(msg: msg),
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
          children: [
            Expanded(
              flex: 1, // réduit le flex
              child: Container(
                height: 80, // réduit la hauteur
                child: Image.network(
                  msg.urlImg!,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(width: 10), // Augmente l'espace entre l'image et le texte
            Expanded(
              flex: 4, // augmente le flex du texte
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    textAlign: TextAlign.start,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    text: TextSpan(
                      style: Theme.of(context).textTheme.bodyText1!,
                      children: <TextSpan>[
                        TextSpan(
                          text: "Title : ",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: kBlueColor,
                          ),
                        ),
                        TextSpan(
                          text: msg.title.toString(),
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
                      style: Theme.of(context).textTheme.bodyText1!,
                      children: <TextSpan>[
                        TextSpan(
                          text: "Description : ",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: kBlueColor,
                          ),
                        ),
                        TextSpan(
                          text: msg.description.toString(),
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
                      style: Theme.of(context).textTheme.bodyText1!,
                      children: <TextSpan>[
                        TextSpan(
                          text: "Prof : ",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: kBlueColor,
                          ),
                        ),
                        TextSpan(
                          text: msg.nomProf.toString(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
