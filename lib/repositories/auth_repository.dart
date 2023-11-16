  import 'package:my_first_flutter_app/http/http_client.dart';
  import 'package:my_first_flutter_app/models/user_model.dart';
  import 'package:my_first_flutter_app/repositories/shared_repository.dart';

  abstract class IAuthRepository {
    Future<UserModel> loginUser(String email, String password);
    Future<void> logoutUser();
  }

  class AuthRepository implements IAuthRepository {
    final IHttpClient client;
    final String url = 'https://8b41-45-171-78-102.ngrok-free.app/api/v1/auth/jwt';

    AuthRepository({required this.client});

    final ISharedPreferencesRepository repository = SharedPreferencesRepository();

    @override
    Future<UserModel> loginUser(String email, String password) async {
      final body = {
        'username': email,
        'password': password,
      };

      if(email == 'alexsander.br18@gmail.com' && password == '123') {
        final user = UserModel(
          id: 1,
          fullName: 'Alexsander',
          email: 'alexsander.br18@gmail.com',
          token: TokenModel(
            access: 'access',
            refresh: 'refresh',
            type: 'bearer'
          ),
        );
        repository.setString('token', user.token.access);
        return Future.delayed(const Duration(seconds: 2), () => user);
      } else {
        throw Exception('Failed to login user');
      }

      // final response = await client.post(url, data: body);

      // if (response.statusCode == 200) {
      //   final body = jsonDecode(response.body);
      //   final user = UserModel.fromMap(body);
      //   repository.setString('token', user.token.access);
      //   return user;
      // } else {
      //   throw Exception('Failed to login user');
      // }
    }

    @override
    Future<void> logoutUser() async {
      await repository.remove('token');
    }
  }
