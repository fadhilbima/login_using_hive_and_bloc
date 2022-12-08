import 'package:hive_flutter/hive_flutter.dart';
import 'package:bloc_hive_login/model/user_data.dart';

class HiveRepo {
  late Box<UserRepo> hiveBox;

  Future<void> init() async {
    Hive.registerAdapter(UserRepoAdapter());
    hiveBox = await Hive.openBox<UserRepo>('hiveBox');
  }

  Future<String?> authenticate(final String emailAddress, final String passwordAdd) async {
    final logging = await hiveBox.values.any(
          (element) => element.email == emailAddress &&
              element.password == passwordAdd,);
    if(logging) {
      return emailAddress;
    }
    return null;
  }

  Future<Attemp> tambahUserEnv(final String emailAddress, final String passwordAdd) async {
    final alreadyExist = hiveBox.values.any(
          (element) => element.email.toLowerCase() == emailAddress.toLowerCase()
    );
    if(alreadyExist) {
      return Attemp.already_exist;
    }
    try {
      hiveBox.add(UserRepo(emailAddress, passwordAdd));
      print(emailAddress);
      return Attemp.success;
    } on Exception catch (_) {
      return Attemp.failed;
    }
  }
}

enum Attemp {success, failed, already_exist}