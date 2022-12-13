import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:bloc_hive_login/repository/authentication_repository.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthenticationRepository authenticationRepository;
  AuthenticationBloc(this.authenticationRepository) : super(AuthenticationInitBox()) {
    on<AuthenticationInitBoxEvent>((event, emit) async {
      await authenticationRepository.init();
      emit(AuthenticationInitial());
    });

    on<AuthenticationSubmitEvent>((event, emit) async {
      authenticationState result = await authenticationRepository.authenticateUser(
        event.email,
        event.password,
      );
      switch (result) {
        case authenticationState.success:
          emit(AuthenticationSuccess(event.email));
          emit(AuthenticationInitial());
          break;
        case authenticationState.failed:
          emit(AuthenticationFailed('Invalid email or password'));
          break;
      }
    });
  }
}
