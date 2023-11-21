import 'package:flutter/material.dart';
import 'package:my_first_flutter_app/repositories/auth_repository.dart';

class AuthStore extends ChangeNotifier {
  final IAuthRepository repository;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  AuthStore({required this.repository});

  Future loginUser(String email, String password, VoidCallback onSucess, Function(String) onError) async {
    try {
      _setLoading(true);
      await repository.loginUser(email, password);
      _setLoading(false);
      onSucess();
    } catch (error) {
      _setLoading(false);
      onError(error.toString());
    }
  }

  Future signUpUser(String email, String password, String confirmPassword, VoidCallback onSucess, Function(String) onError) async {
    try {
      _setLoading(true);
      await repository.signUpUser(email, password, confirmPassword);
      _setLoading(false);
      onSucess();
    } catch (error) {
      _setLoading(false);
      onError(error.toString());
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

  Future forgotPassword(String email, VoidCallback onSucess, Function(String) onError) async {
    try {
      _setLoading(true);
      await repository.forgotPassword(email);
      _setLoading(false);
      onSucess();
    } catch (error) {
      _setLoading(false);
      onError(error.toString());
    }
  }

  Future verifyCode(String code, VoidCallback onSucess, Function(String) onError) async {
    try {
      _setLoading(true);
      await repository.verifyCode(code);
      _setLoading(false);
      onSucess();
    } catch (error) {
      _setLoading(false);
      onError(error.toString());
    }
  }

  Future resetPassword(String password, String confirmPassword, VoidCallback onSucess, Function(String) onError) async {
    try {
      _setLoading(true);
      await repository.resetPassword(password, confirmPassword);
      _setLoading(false);
      onSucess();
    } catch (error) {
      _setLoading(false);
      onError(error.toString());
    }
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}
