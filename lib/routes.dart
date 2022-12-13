import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:bloc_hive_login/screens/home_page.dart';
import 'package:bloc_hive_login/screens/login_page.dart';
import 'package:bloc_hive_login/storage/user_authentication.dart';

class Routes extends StatefulWidget {
  const Routes({Key? key}) : super(key: key);

  @override
  State<Routes> createState() => _RoutesState();
}

class _RoutesState extends State<Routes> {
  bool authenticated = false;
  late Box<UserAuthStorage> loginBox;

  Future<void> init() async {
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(UserAuthStorageAdapter());
    }
  }

  @override
  void initState() {
    super.initState();
    storage();
  }

  Future<void> storage() async {
    loginBox = await Hive.openBox('loginBox');
    if(loginBox.isNotEmpty) {
      setState(() {
        authenticated = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return authenticated ? HomePage() : LoginAppBar();
  }
}
