import 'package:chatify/helpers/constants.dart';
import 'package:chatify/screen_widgets/createMessageTile.dart';
import 'package:chatify/services/db.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ConversationScreen extends StatefulWidget {
  final String chatRoomId;
//  final DocumentSnapshot snapshot;

  ConversationScreen({this.chatRoomId});

  @override
  _ConversationScreenState createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen> {
  final formKey = GlobalKey<FormState>();
  TextEditingController sendMessageTextController = TextEditingController();
  Stream streamMessages;

  sendMessage() {
    if (formKey.currentState.validate()) {
      Map<String, dynamic> messageMap = {
        'message': sendMessageTextController.text,
        'sendBy': Constants.myUserName,
        'time': DateTime.now().millisecondsSinceEpoch
      };
      DatabaseServices().addConversationMessage(widget.chatRoomId, messageMap);
      sendMessageTextController.text = "";
    }
  }

  Widget chatMessageList() {
    return StreamBuilder(
      stream: streamMessages,
      builder: (context, snapshot) {
        return snapshot.hasData
            ? Expanded(
                child: ListView.builder(
                    itemCount: snapshot.data.documents.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text('Today'),
                          ),
                          InkWell(
                            onTap: () {},
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8.0),
                              child: MessageTile(
                                  message: snapshot
                                      .data.documents[index].data["message"],
                                  isSendByMe: snapshot.data.documents[index]
                                          .data["sendBy"] ==
                                      Constants.myUserName),
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
//          title: Text(widget.snapshot.data['username']),
//          actions: <Widget>[
//            CircleAvatar(
//              backgroundColor: Colors.white,
//              backgroundImage: NetworkImage(widget.snapshot.data['photo'] !=
//                      null
//                  ? widget.snapshot.data['photo']
//                  : "${widget.snapshot.data['username'].toString().substring(0, 1).toUpperCase()}"),
//              radius: 25.0,
//            ),
//          ],
//          elevation: 0.0,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            chatMessageList(),
            Container(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(20)),
                        padding: EdgeInsets.all(5.0),
                        margin: EdgeInsets.all(8.0),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Form(
                            key: formKey,
                            child: TextFormField(
                                controller: sendMessageTextController,
                                textCapitalization: TextCapitalization.sentences,
                                keyboardType: TextInputType.multiline,
                                textInputAction: TextInputAction.newline,

                                style: TextStyle(
                                  color: Colors.white,
                                ),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Send Message",
                                  hintStyle: TextStyle(
                                    color: Colors.white70
                                  )
                                )),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        child: IconButton(
                          onPressed: () => sendMessage(),
                          icon: Icon(Icons.send),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ));
  }
}
