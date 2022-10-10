import 'user.dart';

abstract class Services {
  static User? getUser({required String email, required String token}) {
    return User(
        name: 'Jennie Kim', email: 'jennie.kim@blackpink.com', token: token);
  }

  static String? getToken({required String email, required String password}) {
    if (email == 'jennie.kim@blackpink.com' && password == '123456') {
      return 'ABFJOAOOKJ1230SOJD';
    }
    return null;
  }

  static bool isTokenValid(String token) {
    return true;
  }
}
