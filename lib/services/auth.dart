import 'package:chatify/helpers/shared_preferences.dart';
import 'package:chatify/model/firebase_user_model.dart';
import 'package:chatify/services/db.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthServices {
  FirebaseAuth auth = FirebaseAuth.instance;
  GoogleSignIn googleSignIn = GoogleSignIn();

  User _firebaseCustomizedUser(FirebaseUser user) {
    return user != null ? User(uid: user.uid) : null;
  }

  Stream<User> get user {
    return auth.onAuthStateChanged.map(_firebaseCustomizedUser);
  }

  Future<bool> signIn() async {
    try {
      GoogleSignInAccount googleAccount = await googleSignIn.signIn();
      GoogleSignInAuthentication authentication =
          await googleAccount.authentication;
      AuthCredential authCredential = GoogleAuthProvider.getCredential(
          idToken: authentication.idToken,
          accessToken: authentication.accessToken);
      AuthResult authResult = await auth.signInWithCredential(authCredential);
      FirebaseUser user = authResult.user;

      print('User ID: ${user.uid}');
      print('UserName: ${user.displayName}');

      await HelperFunctions().saveUserEmail(userEmail: user.email).then((val){
        print("EMAIL VALUE $val");
      });
      await HelperFunctions().saveUserName(userName: user.displayName)
      .then((val){
        print("USERNAME VALUE $val");
      });
      await HelperFunctions().saveUserPhoto(userPicture: user.photoUrl)
      .then((value) {
        print('USERPHOTO VALUE $value');
      });

      Map<String, dynamic> userMap = {
        'username': user.displayName,
        'email': user.email,
        'photo': user.photoUrl,
        'time': DateTime.now()
      };

      await DatabaseServices(uid: user.uid).uploadUserInfo(userMap);
      _firebaseCustomizedUser(user);
    } catch (e) {
      print(e.toString());
      switch (e.code) {
        case "network_error":
          print('THERE IS NETWORK ERROR');
      }
    }

    return Future.value(true);
  }

  signOut() async {
    try {
      await auth.signOut();
      await googleSignIn.disconnect();
    } catch (error) {
      print(error.toString());
    }
    
  }
}
