import 'package:bloc_hive_login/bloc_arch/authen_bloc.dart';
import 'package:bloc_hive_login/hive_box/hive_repos.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

class Home extends StatelessWidget {
  Home({Key? key, required this.emailAddress}) : super(key: key);
  final String emailAddress;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthenBloc(
        RepositoryProvider.of<HiveRepo>(context),
      )..add(InitializeBoxEvent()),
      child: Scaffold(
        appBar: AppBar(
          title: Align(
            child: Text(emailAddress),
          ),
        ),
        body: BlocConsumer(
          builder: (context, state) {
            if(state is AuthenInitial) {
              return Container(
                child: Text('$emailAddress'),
              );
            } return Container(
              child: Text('$emailAddress'),
            );
          },
          listener: (context, state) {
            if(state is AuthenticateToHome) {

            }
          },
        ),
      ),
    );
  }
}
