import 'package:cached_network_image/cached_network_image.dart';
import 'package:chatify/helpers/constants.dart';
import 'package:chatify/screen_widgets/chatted_list.dart';
import 'package:chatify/screen_widgets/conversation_message_tile.dart';
import 'package:chatify/services/db.dart';
import 'package:chatify/style/style.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ConversationScreen extends StatefulWidget {
  final String chatRoomId;
//  final DocumentSnapshot snapshot;

  ConversationScreen({this.chatRoomId});

  @override
  _ConversationScreenState createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen> {

  TextEditingController sendMessageTextController = TextEditingController();
  Stream streamMessages;

  sendMessage() {
    if (sendMessageTextController.text.isNotEmpty) {
      Map<String, dynamic> messageMap = {
        'message': sendMessageTextController.text,
        'sendBy': Constants.myUserName,
        'senderPhoto': Constants.myPhoto,
        'time': DateTime.now().millisecondsSinceEpoch,
        'time_day': DateFormat.E().add_yMMMMd().add_jm().format(DateTime.now()),
      };
      DatabaseServices().addConversationMessage(widget.chatRoomId, messageMap);
      sendMessageTextController.clear();
    }
  }

  Widget chatMessageList() {
    return StreamBuilder(
      stream: streamMessages,
      builder: (context, snapshot) {
        return snapshot.hasData
            ? Expanded(
                child: ListView.builder(
                  reverse: true,
                    itemCount: snapshot.data.documents.length,
                    itemBuilder: (context, index) {
                      final DocumentSnapshot documentSnapshot =
                          snapshot.data.documents[index];
                      return Column(
                        children: <Widget>[
                          InkWell(
                            onTap: () {},
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8.0),
                              child: ConversationMessageTile(
                                  message: documentSnapshot.data["message"],
                                  isSendByMe: documentSnapshot.data["sendBy"] ==
                                      Constants.myUserName,
                              time: documentSnapshot.data['time_day'] ?? '' ),
                            ),
                          ),
                        ],
                      );
                    }),
              )
            : Container();
      },
    );
  }


  @override
  void initState() {
    DatabaseServices().getConversationMessage(widget.chatRoomId).then((val) {
      setState(() {
        streamMessages = val;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          centerTitle: false,
          /*title: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
                child: Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                          color: Colors.white,
                          width: 1.5
                      )
                  ),
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    backgroundImage: CachedNetworkImageProvider(
                        widget.snapshot.data['photo'].toString()
                    ),
                    radius: 20.0,
                  ),
                ),
              ),
              SizedBox(width: 10.0,),
              Text(widget.snapshot.data['username'],
                  style: TextStyle(
                      fontSize: 15.0
                  ),),
            ],
          ),*/
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            chatMessageList(),
            Container(
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            color: Styles.appBarColor,
                            borderRadius: BorderRadius.circular(20)),
                        padding: EdgeInsets.all(5.0),
                        margin: EdgeInsets.all(8.0),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.0),
                          child: TextFormField(
                              cursorColor: Colors.white70.withOpacity(0.5),
                              controller: sendMessageTextController,
                              textCapitalization: TextCapitalization.sentences,
                              textInputAction: TextInputAction.newline,

                              maxLines: 2,
                              style: TextStyle(
                                color: Colors.white,
                              ),
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Start Conversation",
                                  hintStyle: TextStyle(
                                      color: Colors.white70.withOpacity(0.5))
                              )
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(80, 66, 115, 5.0),
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        child: IconButton(
                          onPressed: (){
                            if(sendMessageTextController.text.trim().isNotEmpty){
                              sendMessage();
                            }

                          },
                          icon: Icon(
                            Icons.send,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        )
    );
  }
}
