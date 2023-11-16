import 'package:my_first_flutter_app/models/user_model.dart';

class AuthState {
  final UserModel user;
  final bool isLoading;

  AuthState({
    required this.user,
    required this.isLoading,
  });

  factory AuthState.initial() {
    return AuthState(
      user: UserModel(
        id: 0,
        fullName: '',
        email: '',
        token: TokenModel(
          access: '',
          refresh: '',
          type: '',
        ),
      ),
      isLoading: false,
    );
  }

  AuthState copyWith({
    UserModel? user,
    bool? isLoading,
  }) {
    return AuthState(
      user: user ?? this.user,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}