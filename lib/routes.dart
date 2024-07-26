import 'package:flutter/material.dart';
import 'package:note/constants/routes_name.dart';
import 'package:note/model/note_model.dart';
import 'package:note/screens/home_page.dart';
import 'package:note/screens/notes/edit_note.dart';
import 'package:note/screens/notes/error_page.dart';
import 'package:note/screens/splash.dart';

import 'screens/notes/note_add.dart';

class Routes {
  static Route? onGenerateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.initialRoute:
        return MaterialPageRoute(builder: (context) => const Splash());
      case RoutesName.homepageRoute:
        return MaterialPageRoute(builder: (context) => const HomePage());
      case RoutesName.editRoute:
        return MaterialPageRoute(
            builder: (context) =>
                EditNote(noteModel: settings.arguments as NoteModel));
      case RoutesName.noteAddRoute:
        return MaterialPageRoute(builder: (context) => const AddNote());
      default:
        return MaterialPageRoute(builder: (context) => const ErrorPage());
    }
  }
}
