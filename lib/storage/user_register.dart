import 'package:hive_flutter/hive_flutter.dart';

part 'user_register.g.dart';

@HiveType(typeId: 0)
class UserRegisterStorage extends HiveObject {
  UserRegisterStorage(this.usernameRegisterStorage, this.emailRegisterStorage, this.passwordRegisterStorage);
  @HiveField(0)
  final String usernameRegisterStorage;
  @HiveField(1)
  final String emailRegisterStorage;
  @HiveField(2)
  final String passwordRegisterStorage;
}