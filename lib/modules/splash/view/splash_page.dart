import 'package:flutter/material.dart';
import 'package:note/modules/home/home.dart';
import 'package:note/utils/navigation.dart';

class SplashPage extends StatefulWidget {
  const SplashPage._({Key? key}) : super(key: key);

  static Widget instance() {
    return SplashPage._();
  }

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    Future.delayed(
      Duration(seconds: 1),
      () => context.navigateReplace(HomePage.route()),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white54,
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
    );
  }
}
