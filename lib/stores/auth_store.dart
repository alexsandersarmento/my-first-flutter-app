import 'package:flutter/material.dart';
import 'package:my_first_flutter_app/repositories/auth_repository.dart';

class AuthStore extends ChangeNotifier {
  final IAuthRepository repository;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  AuthStore({required this.repository});

  Future<(bool,String?)> loginUser(String email, String password) async {
    try {
      _setLoading(true);
      await repository.loginUser(email, password);
      _setLoading(false);
      return(true,null);
    } catch (error) {
      _setLoading(false);
      return (false,error.toString());
    }
  }

  Future<(bool,String?)> logoutUser() async {
    try {
      _setLoading(true);
      await repository.logoutUser();
      _setLoading(false);
      return(true,null);
    } catch (error) {
      _setLoading(false);
      return (false,error.toString());
    }
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}
