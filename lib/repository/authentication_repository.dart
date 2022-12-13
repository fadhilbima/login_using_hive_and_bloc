import 'package:hive_flutter/hive_flutter.dart';
import 'package:bloc_hive_login/storage/user_authentication.dart';
import 'package:bloc_hive_login/storage/user_register.dart';

class AuthenticationRepository {
  late Box<UserAuthStorage> loginBox;
  late Box<UserRegisterStorage> registerBox;

  Future<void> init() async {
    if (!Hive.isAdapterRegistered(1) && !Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(UserAuthStorageAdapter());
      Hive.registerAdapter(UserRegisterStorageAdapter());
    }
    loginBox = await Hive.openBox('loginBox');
    registerBox = await Hive.openBox('registerBox');
  }

  Future<authenticationState> authenticateUser(
      String emailAuthRepo,
      String passwordAuthRepo,
  ) async {
    final success = registerBox.values.any(
          (element) => element.emailRegisterStorage == emailAuthRepo &&
              element.passwordRegisterStorage == passwordAuthRepo);
    await loginBox.add(UserAuthStorage(emailAuthRepo, passwordAuthRepo));
    authenticationState result = success
        ? authenticationState.success
        : authenticationState.failed;
    return result;
  }
}

enum authenticationState {
  success,
  failed,
}