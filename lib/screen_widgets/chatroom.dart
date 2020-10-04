import 'package:cached_network_image/cached_network_image.dart';
import 'package:chatify/helpers/constants.dart';
import 'package:chatify/helpers/shared_preferences.dart';
import 'package:chatify/screen_widgets/conversation_screen.dart';
import 'package:chatify/services/db.dart';
import 'package:chatify/shared/share.dart';
import 'package:chatify/style/style.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatRoom extends StatefulWidget {
  @override
  _ChatRoomState createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {

  @override
  Widget build(BuildContext context) {
    getChatRoomId(String a, String b) {
      if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
        return "$b\_$a";
      } else {
        return "$a\_$b";
      }
    }
    createChatRoomAndStartConversation(
        String userName, DocumentSnapshot documentSnapshot){
      if (userName != Constants.myUserName) {
        String chatRoomId = getChatRoomId(Constants.myUserName, userName);
        List<String> users = [Constants.myUserName, userName];
        Map<String, dynamic> chatRoomMap = {
          'users': users,
          'chatRoomId': chatRoomId
        };
        DatabaseServices().createChatRoom(chatRoomId, chatRoomMap);

        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => ConversationScreen(
                      chatRoomId: chatRoomId,
//                  snapshot: documentSnapshot,
                    )));
      }
      else {
        print('YOU CANNOT CHAT WITH YOURSELF');
        Shared.showSnackbar("You can't chat with yourself");
      }
    }

    return Hero(
      tag: 'chatroom',
      child: Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          title: Text('Chat List'),
          elevation: 0.0,
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: IconButton(
                onPressed: () {},
                icon: Icon(Icons.search),
                iconSize: 22,
              ),
            )
          ],
        ),
        body: StreamBuilder(
          stream: DatabaseServices().streamUsers,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting)
              return Center(child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Styles.appBarColor),
              ));
            if (!snapshot.hasData || snapshot.hasData == null)
              return Center(child: Text('No Data'));
            return Column(
              children: <Widget>[
                Expanded(
                  child: ListView.separated(
                      itemCount: snapshot.data.documents.length,
                      itemBuilder: (context, index) {
                        final DocumentSnapshot documentSnapshot =
                            snapshot.data.documents[index];
                        return InkWell(
                          onTap: () => createChatRoomAndStartConversation(
                                documentSnapshot.data['username'].toString(),
                                documentSnapshot),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 5.0),
                            child: Row(
                              children: <Widget>[
                               Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: Colors.white,
                                      width: 1.5
                                    )
                                  ),
                                      child: CircleAvatar(
                                        radius: 25,
                                        backgroundColor: Styles.appBarColor,
                                        backgroundImage: CachedNetworkImageProvider(
                                            documentSnapshot.data['photo'].toString()
                                        ),
                                      )
//                                      CachedNetworkImage(
//                                        imageUrl: documentSnapshot.data['photo'].toString(),
//                                        placeholder: (context, url) => CircularProgressIndicator(
//                                        ),
//                                        errorWidget: (context, url, error) => Icon(Icons.error),
//                                      )
//                                      CircleAvatar(
//                                          backgroundColor: Styles.appBarColor,
//                                          backgroundImage: CachedNetworkImage()
//                                          /*NetworkImage(
//                                              documentSnapshot.data['photo'] !=
//                                                      null
//                                                  ? documentSnapshot
//                                                      .data['photo']
//                                                  : "${documentSnapshot.data['username'].toString().substring(0, 1).toUpperCase()}"),*/
//                                          radius: 25.0,
//                                        )
                                    ),
                                SizedBox(
                                  width: 25.0,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                          child: Text(
                                        documentSnapshot.data['username'],
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: Styles.messageTitleStyle,
                                      )),
                                      SizedBox(
                                        height: 10.0,
                                      ),
                                      Container(
                                          child: Text(
                                        documentSnapshot.data['email'],
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
                        );
                      },
                   separatorBuilder: (context, index){
                        return Divider(
                          indent: 80.0,
                        );
                  } ,),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}


/*
class SearchFriend extends SearchDelegate<String> {
  var searchList = [
    'kjsf',
    'kjsf',
    'kjsf',
    'kjsf',
    'kjsf',
  ];
  var recentList = [
    'kjsf',
    'kjsf',
    'kjsf',
    'kjsf',
    'kjsf',
  ];

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: Icon(Icons.clear),
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () => close(context, null),
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    return null;
  }

  @override
  Widget buildSuggestions(BuildContext context) {

    final suggestionList = query.isEmpty? recentList : searchList;
    return ListView.builder(
        itemCount: searchList.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(searchList[index]),
          );
        });
  }
}*/
