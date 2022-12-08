import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_hive_login/hive_box/hive_repos.dart';
import 'package:equatable/equatable.dart';

part 'authen_event.dart';
part 'authen_state.dart';

class AuthenBloc extends Bloc<AuthenEvent, AuthenState> {
  HiveRepo _fillBox;
  AuthenBloc(this._fillBox) : super(AuthenAddData()) {
    on<AuthenticateToHome>((event, emit) async {
      await _fillBox.authenticate(event.emailAddres, event.password);
    });
    on<AuthenAddDataEvent>((event, emit) async {
      final added = await _fillBox.tambahUserEnv(event.emailAddress, event.password);
      switch (added) {
        case Attemp.success:
          break;
        case Attemp.failed:
          emit(AuthenInitial(errorMess: 'Error'));
          print('error');
          break;
        case Attemp.already_exist:
          emit(AuthenInitial(errorMess: 'Exist'));
          print('exist');
          break;
      }
    });

    on<InitializeBoxEvent>((event, emit) async {
      await _fillBox.init();
      emit(AuthenInitial());
    });
  }
}
