import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:bloc_hive_login/screens/login_page.dart';
import 'package:bloc_hive_login/storage/user_authentication.dart';
import 'package:bloc_hive_login/storage/user_register.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key, this.email, this.password}) : super(key: key);

  final String? email;
  final String? password;
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Box<UserAuthStorage> loginBox;
  late Box<UserRegisterStorage> registerBox;
  late Box boxReg;
  String? username;
  String? email;
  @override
  void initState() {
    super.initState();
    showIdentity();
  }

  void showIdentity() async {
    if (!Hive.isAdapterRegistered(1) && !Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(UserAuthStorageAdapter());
      Hive.registerAdapter(UserRegisterStorageAdapter());
    }
    loginBox = await Hive.openBox('loginBox');
    registerBox = await Hive.openBox('registerBox');
    boxReg = await Hive.openBox('box');

    username = boxReg.get('username');
    email = boxReg.get('email');
    setState(() {

    });
  }

  void logOut() async {
    loginBox.clear().then(
          (value) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const LoginAppBar()),
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
                  content: Text("You've been logged out", textAlign: TextAlign.center,),
                );
              },
            );
          },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('This is your Home Page $username'),
          actions: [
            IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Icon(Icons.logout, color: Colors.red),
                      content: Text('Log out?', textAlign: TextAlign.center,),
                      actions: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                          onPressed: () {
                            logOut();
                          },
                          child: Text('Log out'),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('Cancel'),
                        ),
                      ],
                    );
                  },
                );
              },
              icon: Icon(Icons.logout, color: Colors.green, size: 30,),
            ),
            SizedBox(width: 10,)
          ],
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Username : $username'),
              Text('Email : $email'),
            ],
          ),
        ),
      ),
    );
  }
}