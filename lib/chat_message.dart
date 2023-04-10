import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class ChatMesage extends StatelessWidget {
  ChatMesage({super.key, required this.text, required this.sender});

  final String text;
  final String sender;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(sender)
              .text
              .subtitle1(context)
              .make()
              .box
              .rounded
              .red200
              .p16
              .color(sender == "user" ? Vx.red200 : Vx.green200)
              .alignCenter
              .makeCentered(),
          // Container(
          //   margin: EdgeInsets.only(right: 16.0),
          //   child: CircleAvatar(
          //     child: Text(sender[0]),
          //   ),
          // ),
          Expanded(child: text.trim().text.bodyText1(context).make().px8()

              //Column(
              //   crossAxisAlignment: CrossAxisAlignment.start,
              //   children: [
              //     Text(
              //       sender,
              //       style: Theme.of(context).textTheme.subtitle1,
              //     ),
              //     Container(
              //       margin: EdgeInsets.only(top: 5.0),
              //       child: Text(text),
              //     ),
              //   ],
              // ),
              )
        ],
      ).py8(),
    );
  }
}
