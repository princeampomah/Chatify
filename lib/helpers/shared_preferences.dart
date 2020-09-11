import 'package:shared_preferences/shared_preferences.dart';

class HelperFunctions{

  static String userEmailKey = "USEREMAILKEY";
  static String userNameKey = "USERNAMEKEY";

  //saving data into SharedPreferences
  Future<bool> saveUserEmail({String userEmail}) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(userEmailKey, userEmail);
  }

  Future<bool> saveUserName({String userName}) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(userNameKey, userName);
  }

  //getting data from ShardPreferences
  Future<String> getUserEmail() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(userEmailKey);
  }

  Future<String> getUserName() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(userNameKey);
  }
}