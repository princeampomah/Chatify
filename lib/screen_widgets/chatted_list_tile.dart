import 'package:chatify/screen_widgets/conversation_screen.dart';
import 'package:chatify/style/style.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatListTile extends StatefulWidget {
  final String userName;
  final String userNameSub;
  final String chatRoomId;
//  final DocumentSnapshot snapshot;

  ChatListTile({this.userName, this.chatRoomId, this.userNameSub});

  @override
  _ChatListTileState createState() => _ChatListTileState();
}

class _ChatListTileState extends State<ChatListTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      ConversationScreen(
                          chatRoomId: widget.chatRoomId,
                      )
              ));
        },
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 17.0, vertical: 10.0),
          child: Row(
            children: <Widget>[
              Container(
                height: 45,
                width: 45,
                decoration: BoxDecoration(
                  color: Styles.appBarColor,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.white,
                    width: 1.5
                  )
                ),
                child: Center(child: Text(
                    widget.userNameSub,
                  style: TextStyle(
                    color: Colors.white
                  ),
                ))
              ),
              SizedBox(
                width: 25.0,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                        child: Text(
                      widget.userName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Styles.messageTitleStyle,
                    )),
                    SizedBox(
                      height: 10.0,
                    ),
                    Container(
                        child: Text(
                      "Message must be here",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Styles.messageContentStyle,
                    )),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
