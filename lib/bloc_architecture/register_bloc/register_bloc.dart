import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:bloc_hive_login/repository/register_repository.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final RegisterRepository registerRepository;
  RegisterBloc(this.registerRepository) : super(RegisterInitBox()) {
    on<RegisterInitBoxEvent>((event, emit) async {
      await registerRepository.init();
      emit(RegisterInitial());
    });

    on<RegisterSubmitEvent>((event, emit) async {
      registerState result = await registerRepository.registerUser(
        event.username,
        event.email,
        event.password,
      );
      switch (result) {
        case registerState.success:
          emit(RegisterSuccess(event.username));
          emit(RegisterInitial());
          break;
        case registerState.exist:
          emit(RegisterFailed('Your email has exist'));
          break;
      }
    });
  }
}
