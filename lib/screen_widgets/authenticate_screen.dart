
import 'package:chatify/services/auth.dart';
import 'package:chatify/shared/share.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  AuthServices authService = AuthServices();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    login() async {
      setState(() => isLoading = true);
      try {
        await authService.signIn().whenComplete(() async {
//           FirebaseUser user = await FirebaseAuth.instance.currentUser();
//           print("Testing Firbase ${user.photoUrl}");

          print('YOU ARE LOGGED IN');
        });
      } catch (e) {
        print('WHEN ACCOUNT IS NOT SELECTED ERROR: ${e.toString()}');
        setState(() {
          isLoading = false;
        });
      }

      bool result = await DataConnectionChecker().hasConnection;
      if (result == false) {
        setState(() {
          isLoading = false;
        });
        print('CHECK UR INTERNET');
        Shared.showSnackbar('No Internet Connection');
      }
    }

    return SafeArea(
      child: Scaffold(
          key: scaffoldKey,
          body: Container(
            alignment: Alignment.center,
            child: Column(
              children: <Widget>[
                Expanded(
                  child: Container(
                    child: Image.asset(
                      'assets/images/login.jpg',
                      scale: 2.5,
                    ),
                  ),
                ),
                Container(
                  child: Column(
                    children: <Widget>[
                      isLoading
                          ? SpinKitWanderingCubes(
                            shape: BoxShape.circle,
                              size: 37.0,
                              color: Color(0xFF4285F4),
                            )
                          : Text(''),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.bottomCenter,
                    margin: EdgeInsets.only(bottom: 40.0),
                    child: GoogleSignInButton(
                      onPressed: login,
                      darkMode: true,
                      splashColor: Colors.lightBlueAccent,
                      textStyle: TextStyle(
                          fontSize: 12.0,
                          color: Colors.white,
                          fontStyle: FontStyle.normal),
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
