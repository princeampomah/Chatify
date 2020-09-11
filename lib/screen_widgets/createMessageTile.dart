import 'package:flutter/material.dart';

class MessageTile extends StatefulWidget {
  final String message;
  final bool isSendByMe;

  MessageTile({this.message, this.isSendByMe});

  @override
  _MessageTileState createState() => _MessageTileState();
}

class _MessageTileState extends State<MessageTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 4.0),
      alignment:
      widget.isSendByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 22.0, vertical: 16.0),
        margin: EdgeInsets.only(left: widget.isSendByMe? 24: 0 , right: widget.isSendByMe? 0: 24),
        decoration: BoxDecoration(
          color: widget.isSendByMe ? Colors.redAccent : Colors.grey,
          borderRadius: widget.isSendByMe
              ? BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
            bottomLeft: Radius.circular(15),
          )
              : BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
            bottomRight: Radius.circular(15),
          ),
        ),
        child: Container(
          child: Text(
            widget.message,
            style: TextStyle(),
          ),
        ),
      ),
    );
  }
}


