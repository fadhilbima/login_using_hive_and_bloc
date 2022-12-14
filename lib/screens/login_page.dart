import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_hive_login/bloc_architecture/authentication_bloc/authentication_bloc.dart';
import 'package:bloc_hive_login/repository/authentication_repository.dart';
import 'package:bloc_hive_login/screens/home_page.dart';
import 'package:bloc_hive_login/screens/register_page.dart';

class LoginAppBar extends StatelessWidget {
  const LoginAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Login Page'),
        ),
        body: BlocProvider(
          create: (context) {
            return AuthenticationBloc(
              RepositoryProvider.of<AuthenticationRepository>(context)
            )..add(AuthenticationInitBoxEvent());
          },
          child: LoginBody(),
        ),
      ),
    );
  }
}

class LoginBody extends StatelessWidget {
  LoginBody({Key? key}) : super(key: key);
  final emailAuth = TextEditingController();
  final passwordAuth = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        if (state is AuthenticationSuccess) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => HomePage(),
              ),
                  (route) => false,
          );

          showDialog(
            context: context,
            builder: (context) {
              Future.delayed(
                Duration(seconds: 1),
                  () => Navigator.of(context).pop(true),
              );
              return AlertDialog(
                title: Icon(
                  Icons.login,
                  color: Colors.blue,
                ),
                content: Text(
                  "You're Logged in ${state.email}",
                  textAlign: TextAlign.center,
                ),
              );
            },
          );
        }
        if (state is AuthenticationFailed) {
          showDialog(
            context: context,
            builder: (context) {
              Future.delayed(
                Duration(seconds: 1),
                  () => Navigator.of(context).pop(true),
              );
              return AlertDialog(
                title: Icon(
                  Icons.cancel,
                  color: Colors.red,
                ),
                content: Text(
                  '${state.errorMess}',
                  textAlign: TextAlign.center,
                ),
              );
            },
          );
        }
      },
      child: Column(
        children: [
          Form(
            key: _formKey,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFormField(
                    controller: emailAuth,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Email'
                    ),
                    validator: (v) {
                      if (v == null || v.isEmpty) {
                        return 'Email is necessary';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: passwordAuth,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Password'
                    ),
                    validator: (v) {
                      if (v == null || v.isEmpty) {
                        return 'Blank Password';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(fixedSize: Size(double.infinity, 40)),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        context.read<AuthenticationBloc>().add(
                          AuthenticationSubmitEvent(
                            emailAuth.text,
                            passwordAuth.text,
                          ),
                        );
                      }
                    },
                    child: Text('Submit'),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Dont have any Account?'),
                      SizedBox(width: 5),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context){
                            return RegisterAppBar();
                          }));
                        },
                        child: Text('Click here.', style: TextStyle(color: Colors.blue),),
                      ),
                    ],
                  ),
                ],
              ),
            )
          )
        ],
      ),
    );
  }
}

