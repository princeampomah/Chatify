import 'package:shared_preferences/shared_preferences.dart';

class HelperFunctions{

  static String userEmailKey = "USEREMAILKEY";
  static String userNameKey = "USERNAMEKEY";
  static String userPhoto = "USERPHOTO";
  static String chatID = "CHATID";

  //saving data into SharedPreferences
  Future<bool> saveUserEmail({String userEmail}) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(userEmailKey, userEmail);
  }

  Future<bool> saveUserName({String userName}) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(userNameKey, userName);
  }

  Future<bool> saveUserPhoto({String userPicture}) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(userPhoto, userPicture);
  }

  Future<bool> saveChatId({String chatId}) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(chatID, chatId);
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

  Future<String> getUserPhoto() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(userPhoto);
  }

  Future<String> getChatId() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(chatID);
  }
}