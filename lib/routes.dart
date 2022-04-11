import 'package:flutter/material.dart';
import 'package:noteapp/model/notes_model.dart';
import 'package:noteapp/screen/final_delete.dart';
import 'package:noteapp/screen/home_screen.dart';
import 'package:noteapp/screen/notes_add.dart';
import 'package:noteapp/screen/notes_list.dart';
import 'package:noteapp/screen/recycle_bin.dart';
import 'package:noteapp/screen/sign_up.dart';

class Routes {
  static Route? onGenerateRoutes(RouteSettings settings) {
    switch (settings.name) {

      /// splash
      case "/":
        return MaterialPageRoute(builder: (context) => const HomeScreen());

      /// notes list
      case NotesList.routeName:
        return MaterialPageRoute(builder: (context) => const NotesList());

      /// add new note
      case NotesAdd.routeName:
        return MaterialPageRoute(
            builder: (context) =>
                NotesAdd(map: settings.arguments as Map<String, dynamic>));

      /// sign up
      case SignUp.routeName:
        return MaterialPageRoute(builder: (context) => const SignUp());

      /// bin
      case Bin.routeName:
        return MaterialPageRoute(builder: (context) => const Bin());

      /// final delete
      case FinalDelete.routeName:
        return MaterialPageRoute(
          builder: (context) => FinalDelete(
            note: settings.arguments as NotesModel,
          ),
        );
    }
  }
}
