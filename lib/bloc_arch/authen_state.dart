part of 'authen_bloc.dart';

abstract class AuthenState extends Equatable {
  const AuthenState();
}

class AuthenInitial extends AuthenState {
  final String? errorMess;

  AuthenInitial({this.errorMess});
  @override
  List<Object?> get props => [errorMess];
}

class AuthenAddData extends AuthenState {
  @override
  List<Object?> get props => [];
}

class IntoHome extends AuthenState {
  final String emailMatch;
  IntoHome(this.emailMatch);
  @override
  List<Object?> get props => [emailMatch];
}