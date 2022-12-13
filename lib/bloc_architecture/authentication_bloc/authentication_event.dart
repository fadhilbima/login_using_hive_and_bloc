part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();
}

class AuthenticationInitBoxEvent extends AuthenticationEvent {
  @override
  List<Object> get props => [];
}

class AuthenticationSubmitEvent extends AuthenticationEvent {
  final String email;
  final String password;
  AuthenticationSubmitEvent(this.email, this.password);
  @override
  List<Object> get props => [email, password];
}