import 'package:flutter/material.dart';
import 'package:note/constants/colors.dart';
import 'package:note/constants/routes_name.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    Future.delayed(
        const Duration(seconds: 1),
        () =>
            Navigator.pushReplacementNamed(context, RoutesName.homepageRoute));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.white54,
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
    );
  }
}
