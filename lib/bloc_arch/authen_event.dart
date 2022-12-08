part of 'authen_bloc.dart';

abstract class AuthenEvent extends Equatable {
  const AuthenEvent();
}

class InitializeBoxEvent extends AuthenEvent {
  @override
  List<Object?> get props => [];
}

class AuthenAddDataEvent extends AuthenEvent {
  AuthenAddDataEvent(this.emailAddress, this.password);
  final String emailAddress;
  final String password;
  @override
  List<Object> get props => [emailAddress, password];
}

class AuthenticateToHome extends AuthenEvent {
  final String emailAddres;
  final String password;

  AuthenticateToHome(this.emailAddres, this.password);
  @override
  List<Object?> get props => [emailAddres, password];
}