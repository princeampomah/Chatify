import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseServices {
  String uid;
  DatabaseServices({this.uid});

 static CollectionReference usersCollection = Firestore.instance.collection('users');
 static CollectionReference chatRoomCollection = Firestore.instance.collection('ChatRoom');

  uploadUserInfo(userMap) async {
    return await usersCollection
        .document(uid)
        .setData(userMap)
        .catchError((error) {
      print("Upload User Info Error: ${error.toString()}");
    });
  }

  Stream streamUsers = usersCollection.orderBy('username', descending: false).snapshots();

  createChatRoom(String chatRoomId, chatRoomMap){
    chatRoomCollection.document(chatRoomId).setData(chatRoomMap)
    .catchError((error){
      print('Create Chat Room DB Error: ${error.toString()}');
    });
  }

  addConversationMessage(String chatRoomId, messageMap){
    chatRoomCollection.document(chatRoomId)
        .collection('chat')
        .add(messageMap)
    .catchError((error){
      print('ERROR at addConversationMessage');
    });
  }

  getConversationMessage(String chatRoomId) async{
   return await chatRoomCollection.document(chatRoomId)
        .collection('chat')
        .orderBy('time', descending: true)
        .snapshots();
  }

  getChatRooms(String userName) async{
    return await chatRoomCollection
        .where('users', arrayContains:userName)
        .snapshots();
  }




/*  UsersInfo _usersInfoFromDocumentSnapshot(DocumentSnapshot snapshot){
    return UsersInfo(
      userName: snapshot.data['username'],
      userEmail: snapshot.data['email'],
      userPhoto: snapshot.data['photo']
    );
  }

  Stream<UsersInfo> get usersInfo{
    return usersCollection.document(uid).snapshots()
    .map(_usersInfoFromDocumentSnapshot);
  }*/


}
