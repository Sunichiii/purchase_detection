import 'package:flutter/material.dart';
import 'package:pika_pika/pages/authentication/register_page.dart';

import 'login_page.dart';

class LoginOrRegister extends StatefulWidget {
  const LoginOrRegister({super.key});

  @override
  State<LoginOrRegister> createState() => _LoginOrRegisterState();
}

class _LoginOrRegisterState extends State<LoginOrRegister> {
  //initially show login page
  bool showLoginPage = true;

  //toggle between login and register page
  void togglePages(){
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginPage){
      return LoginPage(onRegisterTap: togglePages);
    } else{
      return RegisterPage(onLoginTap: togglePages,);
    }
  }
}
