import 'package:bloc_hive_login/bloc_arch/authen_bloc.dart';
import 'package:bloc_hive_login/hive_box/hive_repos.dart';
import 'package:bloc_hive_login/model/user_data.dart';
import 'package:bloc_hive_login/screens/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final HiveRepo repo = HiveRepo();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Align(
            child: Text('Login'),
          ),
        ),
        body: BlocProvider(
          create: (context) => AuthenBloc(
            RepositoryProvider.of<HiveRepo>(context),
          )..add(InitializeBoxEvent()),
          child: BlocConsumer<AuthenBloc, AuthenState>(
            listener: (context, state) {
              if(state is AuthenAddData) {
              }
              if(state is AuthenInitial) {
                if (state.errorMess != null)
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('Error'),
                      content: Text(state.errorMess!),
                    ),
                  );
              }
            },
            builder: (context, state) {
              if(state is AuthenInitial) {
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      TextFormField(
                        controller: emailController,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Email'
                        ),
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        controller: passwordController,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Password'
                        ),
                      ),
                      SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () {
                          BlocProvider.of<AuthenBloc>(context).add(
                            AuthenAddDataEvent(emailController.text, passwordController.text)
                          );
                          BlocProvider<AuthenBloc>(
                            create: (context) => AuthenBloc(repo),
                            child: Home(emailAddress: emailController.text),
                          );
                        },
                        child: Text('Submit'),
                      )
                    ],
                  ),
                );
              }
              return Container();
            },
          ),
        )
    );
  }
}