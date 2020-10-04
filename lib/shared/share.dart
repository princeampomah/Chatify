import 'package:chatify/services/auth.dart';
import 'package:chatify/style/style.dart';
import 'package:flutter/material.dart';

GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
AuthServices authServices = AuthServices();

class Shared {
  static showSnackbar(String content) {
    SnackBar snackBar = SnackBar(
      content: Text(
        content,
        textAlign: TextAlign.center,
      ),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
    );
    scaffoldKey.currentState.showSnackBar(snackBar);
  }

  static Widget popUpMenuButton() {
    final String logout = 'logout';
    onItemSelected(value) {
      if (value == logout) {
        authServices.signOut();
      }
    }

    return PopupMenuButton(
        icon: Icon(Icons.more_vert),
        onSelected: onItemSelected,
        itemBuilder: (context) => <PopupMenuEntry<String>>[
              PopupMenuItem(value: logout, child: Text('Logout')),
            ]);
  }

  static Widget appBar() {
    return AppBar(
      title: Text('Chatify'),
      actions: <Widget>[popUpMenuButton()],
    );
  }
}
