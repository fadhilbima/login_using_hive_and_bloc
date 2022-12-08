import 'package:hive_flutter/hive_flutter.dart';

part 'user_data.g.dart';

@HiveType(typeId: 1)
class UserRepo{
  UserRepo(this.email, this.password);
  @HiveField(0)
  final String email;
  @HiveField(1)
  final String password;
}