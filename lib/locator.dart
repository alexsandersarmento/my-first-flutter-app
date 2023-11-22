import 'package:get_it/get_it.dart';
import 'package:my_first_flutter_app/repositories/shared_repository.dart';
import 'package:my_first_flutter_app/stores/auth_store.dart';
import 'package:my_first_flutter_app/repositories/auth_repository.dart';
import 'package:my_first_flutter_app/http/http_client.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerSingleton<SharedPreferencesRepository>(SharedPreferencesRepository());
  locator.registerLazySingleton<HttpClient>(() => HttpClient());
  locator.registerLazySingleton<AuthRepository>(() => AuthRepository(client: locator<HttpClient>()));
  locator.registerSingleton<AuthStore>(AuthStore(repository: locator<AuthRepository>()));
}