import 'package:flutter/material.dart';
import 'package:noteapp/screen/login_screen.dart';
class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);
static const String routeName='home';
  @override
  Widget build(BuildContext context) {
    return const LogIn();
  }
}
