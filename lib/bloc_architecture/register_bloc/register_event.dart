part of 'register_bloc.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();
}

class RegisterInitBoxEvent extends RegisterEvent {
  @override
  List<Object> get props => [];
}

class RegisterSubmitEvent extends RegisterEvent {
  final String username;
  final String email;
  final String password;
  RegisterSubmitEvent(this.username, this.email, this.password);
  @override
  List<Object> get props => [username, email, password];
}
