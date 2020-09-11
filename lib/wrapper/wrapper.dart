import 'package:chatify/model/firebase_user_model.dart';
import 'package:chatify/screen_widgets/authenticate_screen.dart';
import 'package:chatify/screen_widgets/chatroom.dart';
import 'package:chatify/screen_widgets/list_chat.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);
    if(user != null){
      return ListChat();
    }
    else{
      return SignIn();
    }
  }
}
