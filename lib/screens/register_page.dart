import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_hive_login/bloc_architecture/register_bloc/register_bloc.dart';
import 'package:bloc_hive_login/repository/register_repository.dart';
import 'package:bloc_hive_login/screens/login_page.dart';


class RegisterAppBar extends StatelessWidget {
  const RegisterAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Register Page'),
        ),
        body: BlocProvider(
          create: (context) {
            return RegisterBloc(
              RepositoryProvider.of<RegisterRepository>(context)
            )..add(RegisterInitBoxEvent());
          },
          child: RegisterBody(),
        ),
      ),
    );
  }
}

class RegisterBody extends StatelessWidget {
  RegisterBody({Key? key}) : super(key: key);
  final usernameRegister = TextEditingController();
  final emailRegister = TextEditingController();
  final passwordRegister = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterBloc, RegisterState>(
      listener: (context, state) {
        if(state is RegisterSuccess) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => LoginAppBar()),
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
                  Icons.input,
                  color: Colors.blue,
                ),
                content: Text(
                  'Your account created ${state.username}, \n You may login',
                  textAlign: TextAlign.center,
                ),
              );
            },
          );
        }
        if(state is RegisterFailed) {
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
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Form(
            key: _formKey,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFormField(
                    controller: usernameRegister,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Username'
                    ),
                    validator: (v) {
                      if (v == null || v.isEmpty) {
                        return 'Username required';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: emailRegister,
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
                    controller: passwordRegister,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Password'
                    ),
                    validator: (v) {
                      if (v == null || v.isEmpty) {
                        return 'Blank password';
                      }
                    },
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(fixedSize: Size(double.infinity, 40)),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        context.read<RegisterBloc>().add(
                          RegisterSubmitEvent(
                            usernameRegister.text,
                            emailRegister.text,
                            passwordRegister.text,
                          ),
                        );
                      }
                    },
                    child: Text('Create Account'),
                  ),
                  SizedBox(height: 10),
                ],
              ),
            )
          )
        ],
      ),
    );
  }
}


