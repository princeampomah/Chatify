
import 'package:flutter/material.dart';

abstract class Styles {
  static const TextStyle appBarStyle = TextStyle(
    color: scaffoldBackgroundColor,
  );
  static const TextStyle messageTitleStyle = TextStyle(
    // color: messageTitleColor,
    fontSize: 13.0,
    fontWeight: FontWeight.w700,
  );
  static const TextStyle messageContentStyle = TextStyle(
    color: messageContentColor,
    fontSize: 12.5,
  );
  static const TextStyle timeStyle = TextStyle(
    color: messagesContainerColor,
    fontSize: 11.0,
  );
  static const TextStyle noOfMessageStyle = TextStyle(
    color: scaffoldBackgroundColor,
    fontSize: 10.0,
  );

  static const TextStyle tabBarStyle = TextStyle(
    fontSize: 13.5,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.5,
    );

  static const Color scaffoldBackgroundColor = Color.fromRGBO(255, 254, 255, 1.0);
  static const Color appBarColor = Color.fromRGBO(7, 93, 86, 1.0);
  static const Color timeColor = Color.fromRGBO(0, 204, 63, 1.0);
  static const Color messagesContainerColor = Color.fromRGBO(0, 204, 63, 1.0);
  static const Color messageTitleColor = Color.fromRGBO(45, 44, 45, 1.0);
  static const Color messageContentColor = Color.fromRGBO(194, 192, 194, 1.0);
  static const Color dividerColor = Color.fromRGBO(194, 192, 194, 1.0);
}
