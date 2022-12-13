// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_register.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserRegisterStorageAdapter extends TypeAdapter<UserRegisterStorage> {
  @override
  final int typeId = 0;

  @override
  UserRegisterStorage read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserRegisterStorage(
      fields[0] as String,
      fields[1] as String,
      fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, UserRegisterStorage obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.usernameRegisterStorage)
      ..writeByte(1)
      ..write(obj.emailRegisterStorage)
      ..writeByte(2)
      ..write(obj.passwordRegisterStorage);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserRegisterStorageAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
