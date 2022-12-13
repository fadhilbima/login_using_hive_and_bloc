part of 'authentication_bloc.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();
}

class AuthenticationInitial extends AuthenticationState {
  @override
  List<Object> get props => [];
}

class AuthenticationInitBox extends AuthenticationState {
  @override
  List<Object> get props => [];
}

class AuthenticationSuccess extends AuthenticationState {
  final String email;
  AuthenticationSuccess(this.email);

  @override
  List<Object> get props => [email];
}

class AuthenticationFailed extends AuthenticationState {
  final String? errorMess;
  AuthenticationFailed(this.errorMess);
  @override
  List<Object> get props => [errorMess ?? ''];
}
