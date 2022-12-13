import 'package:hive_flutter/hive_flutter.dart';

part 'user_authentication.g.dart';

@HiveType(typeId: 1)
class UserAuthStorage extends HiveObject {
  UserAuthStorage(this.emailAuthStorage, this.passwordAuthStorage);
  @HiveField(0)
  final String emailAuthStorage;
  @HiveField(1)
  final String passwordAuthStorage;
}