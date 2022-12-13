part of 'register_bloc.dart';

abstract class RegisterState extends Equatable {
  const RegisterState();
}

class RegisterInitial extends RegisterState {
  @override
  List<Object> get props => [];
}

class RegisterInitBox extends RegisterState {
  @override
  List<Object> get props => [];
}

class RegisterSuccess extends RegisterState {
  final String username;
  RegisterSuccess(this.username);
  @override
  List<Object> get props => [username];
}

class RegisterFailed extends RegisterState {
  final String? errorMess;
  RegisterFailed(this.errorMess);
  @override
  List<Object> get props => [errorMess ?? ''];
}
