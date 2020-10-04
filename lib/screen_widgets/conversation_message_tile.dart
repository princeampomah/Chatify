import 'package:cached_network_image/cached_network_image.dart';
import 'package:chatify/style/style.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ConversationMessageTile extends StatefulWidget {
  final String message;
  final bool isSendByMe;
  final String time;

  ConversationMessageTile({this.message, this.isSendByMe, this.time});

  @override
  _ConversationMessageTileState createState() => _ConversationMessageTileState();
}

class _ConversationMessageTileState extends State<ConversationMessageTile> {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 4.0),
          alignment:
          widget.isSendByMe ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            padding: EdgeInsets.only(right: 5.0, top: 5.0, bottom: 2.0, left: 2.0),
            margin: EdgeInsets.only(left: widget.isSendByMe? 24: 0 , right: widget.isSendByMe? 0: 24),
            decoration: BoxDecoration(
              color: widget.isSendByMe ? Color.fromRGBO(192, 214, 255, 5.0) : Color.fromRGBO(255, 254, 255, 5.0),
              borderRadius: widget.isSendByMe
                  ? BorderRadius.only(
                topLeft: Radius.circular(10),
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              )
                  : BorderRadius.only(
                topRight: Radius.circular(10),
                bottomRight: Radius.circular(10),
                bottomLeft: Radius.circular(10),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                  child: Text(
                    widget.message,
                    style: TextStyle(
                        color: Styles.appBarColor
                    ),
                  ),
                ),
                Icon(widget.isSendByMe? Icons.done_all : null, size: 8, color: Colors.blue,),

              ],
            ),
          ),
        ),
        Container(
            padding: EdgeInsets.only(left: widget.isSendByMe? 0.0 : 10.0, right: widget.isSendByMe? 10.0 : 0.0,),
            alignment: widget.isSendByMe? Alignment.bottomRight : Alignment.bottomLeft ,
            child: Text(widget.time,
              style: TextStyle(
                fontSize: 8.5,
              ),)
        )
      ],
    );
  }
}


