import 'package:flutter/material.dart';
import 'package:noteapp/model/notes_model.dart';
import 'package:noteapp/screen/final_delete.dart';
import 'package:noteapp/screen/notes_add.dart';
import 'package:noteapp/screen/notes_list.dart';
import 'package:noteapp/screen/recycle_bin.dart';

class Routes {
  static Route? onGenerateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (context) => const NotesList());
      case '/add':
        return MaterialPageRoute(
            builder: (context) =>
                NotesAdd(map: settings.arguments as Map<String, dynamic>));
      case '/bin':
        return MaterialPageRoute(builder: (context) => const Bin());
      case '/finalDelete':
        return MaterialPageRoute(
          builder: (context) => FinalDelete(
            note: settings.arguments as NotesModel,
          ),
        );
    }
  }
}
