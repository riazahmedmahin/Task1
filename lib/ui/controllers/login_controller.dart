

import 'package:get/get.dart';

import '../../data/models/user_model.dart';
import '../../data/network_caller/network_caller.dart';
import '../../data/network_caller/network_response.dart';
import '../../data/utility/urls.dart';
import 'auth_controller.dart';

class LoginController extends GetxController{

  bool _loginProgress = false;
  String _failedmessage = '';

  bool get loginInProgress=>_loginProgress;

  String get failureMessage => _failedmessage;

  Future<bool> login(String email, String password) async {

    _loginProgress = true;

    update();

    NetworkResponse response =
    await NetworkCaller().postRequest(Urls.login, body: {
      "email": email,
      "password": password,
    }, isLogin: true);
    _loginProgress = false;
   update();
    if (response.isSuccess) {
      await Get.find<AuthController>().SaveUserInformation(
          response.jsonResponse['token'], UserModel.fromJson(response.jsonResponse['data']));
     return true;
    } else {
      if (response.statusCode == 401) {
        _failedmessage = 'Please check email or password';
      } else {
         {
           _failedmessage= 'Login Failed. Try Again';
        }
      }
      return false;
    }
  }
}