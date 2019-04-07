import 'package:skeletal_app/src/beans/User.dart';

class UserSingleton{
  static final UserSingleton _userSingleton = new UserSingleton._internal();
  User user;

  factory UserSingleton(){
    return _userSingleton;
  }

  UserSingleton._internal();
}