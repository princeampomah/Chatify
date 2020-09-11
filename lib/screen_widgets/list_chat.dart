import 'package:chatify/helpers/constants.dart';
import 'package:chatify/helpers/shared_preferences.dart';
import 'package:chatify/screen_widgets/chatroom.dart';
import 'package:chatify/screen_widgets/createChatListTile.dart';
import 'package:chatify/services/db.dart';
import 'package:chatify/shared/share.dart';
import 'package:chatify/style/style.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ListChat extends StatefulWidget {
  @override
  _ListChatState createState() => _ListChatState();
}

class _ListChatState extends State<ListChat> {
  Stream streamChatList;

  @override
  void initState() {
    getUserName();

    super.initState();
  }

  getUserName() async {
    Constants.myUserName = await HelperFunctions().getUserName();
    DatabaseServices().getChatRooms(Constants.myUserName).then((val) {
      setState(() {
        streamChatList = val;
      });
    });
    print('Get UserName From SharedPrefs: ${Constants.myUserName}');

  }

  Widget chatList() {
    return StreamBuilder(
      stream: streamChatList,
      builder: (context, snapshot) {
        return snapshot.hasData? ListView.builder(
            itemCount: snapshot.data.documents.length,
            itemBuilder: (context, index) {
              final DocumentSnapshot documentSnapshot =
              snapshot.data.documents[index];
              return ChatListTile(
              userName: documentSnapshot.data['chatRoomId']
                .toString().replaceAll("_", "")
                .replaceAll(Constants.myUserName, ""),
                chatRoomId: documentSnapshot.data['chatRoomId'],
              );
            }) : Container();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Shared.appBar(),
      body: Column(
        children: <Widget>[
          Expanded(
              child: chatList()
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => ChatRoom())),
        backgroundColor: Colors.white,
        child: Icon(Icons.chat),
        splashColor: Colors.blue,
        elevation: 16.0,
      ),
    );
  }
}


