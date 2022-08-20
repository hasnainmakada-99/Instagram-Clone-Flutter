import 'package:instagram_clone/Authentication/AuthUser.dart';
import '../Models/user_model.dart';
import 'package:flutter/cupertino.dart';

class UserProvider with ChangeNotifier {
  AuthUser authUser = AuthUser();
  User? _user;
  User get getUser => _user!;

  Future<void> refreshUser() async {
    User user = await authUser.getUserDetails();
    _user = user;
    notifyListeners();
  }
}
