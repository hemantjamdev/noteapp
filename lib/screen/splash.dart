/*
import 'package:flutter/material.dart';
import 'package:noteapp/screen/notes_list.dart';
class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);
  static const String routeName='splash';

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(seconds: 1),()=>Navigator.pushReplacementNamed(context, NotesList.routeName));
  }
  @override
  Widget build(BuildContext context) {
    return  Container(
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(
          image:DecorationImage(image:Image.asset('assets/splash.png').image )
      ),
      //child: Center(child: Text('home screen'),),
    );
  }
}*/
