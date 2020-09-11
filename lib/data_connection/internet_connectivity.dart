import 'package:chatify/shared/share.dart';
import 'package:data_connection_checker/data_connection_checker.dart';

class CheckInternetConnectivity {
  internetConnection(bool loading) async {
    bool result = await DataConnectionChecker().hasConnection;
    if (result == false) {
      Shared.showSnackbar('Not Connected');
      print('No Internet');
    }
  }
}
