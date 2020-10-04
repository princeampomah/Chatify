import 'package:chatify/services/auth.dart';
import 'package:chatify/style/style.dart';
import 'package:chatify/wrapper/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return StreamProvider.value(
      value: AuthServices().user,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          brightness: Brightness.light,
          scaffoldBackgroundColor: Styles.scaffoldBackgroundColor,
          appBarTheme: AppBarTheme(color: Styles.appBarColor, elevation: 0.0),
          primarySwatch: Colors.blueGrey,
          accentColor: Colors.blueGrey,
        ),
        home: Wrapper()
      ),
    );
  }
}
