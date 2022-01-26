import 'package:flutter/widgets.dart';
import '../models/user_model.dart';
import '../resources/auth_methods.dart';

class UserProvider extends ChangeNotifier {
  UserModel? _user;
  final AuthMethods _authMethods = AuthMethods();

  UserModel get getUser => _user!;

//* Refreshs the username when changed in the firebase 
  Future<void> refreshUsername() async {
    final user = await _authMethods.getUserDetail();
    _user = user;
    notifyListeners();
  }
}
