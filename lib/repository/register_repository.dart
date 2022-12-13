import 'package:hive_flutter/hive_flutter.dart';
import 'package:bloc_hive_login/storage/user_register.dart';

class RegisterRepository {
  late Box<UserRegisterStorage> registerBox;
  late Box boxReg;

  Future<void> init() async {
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(UserRegisterStorageAdapter());
    }
    registerBox = await Hive.openBox('registerBox');
    boxReg = await Hive.openBox('box');
  }

  Future<registerState> registerUser(
      String usernameRegisterRepo,
      String emailRegisterRepo,
      String passwordRegisterRepo,
  )
  async {
    final registerAccountExist = registerBox.values.any(
          (element) => element.emailRegisterStorage.toLowerCase() == 
              emailRegisterRepo.toLowerCase(),
    );
    if (registerAccountExist) {
      return registerState.exist;
    } else {
      await registerBox.add(UserRegisterStorage(usernameRegisterRepo, emailRegisterRepo, passwordRegisterRepo));

      await boxReg.put('username', usernameRegisterRepo);
      await boxReg.put('email', emailRegisterRepo);
      return registerState.success;
    }
  }
}

enum registerState {success, exist}