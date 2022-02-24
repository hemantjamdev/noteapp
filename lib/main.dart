import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:noteapp/screen/notes_list.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'constant/strings.dart';
import 'model/notes_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// temp directory for database
  Directory directory = await path_provider.getApplicationDocumentsDirectory();

  /// hive database initialize
  Hive.init(directory.path);

  /// register adapter for store notes_model
  Hive.registerAdapter(NotesModelAdapter());

  ///create box(table) to store notes
  await Hive.openBox<NotesModel>(Strings.dbName);
  await Hive.openBox<NotesModel>(Strings.binDbName);

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((value) => runApp(const NotesApp()));
}

class NotesApp extends StatelessWidget {
  const NotesApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "TODO",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.orange),
      home: const NotesList(),
    );
  }
}

///splash screen
/*
class Splash extends StatelessWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [
                const Color(0xFFF8A016),
                const Color(0xFFFF6F00),
              ],
              begin: const FractionalOffset(0.0, 1.0),
              end: const FractionalOffset(1.0, 0.0),
              stops: [0.0, 1.0],
              tileMode: TileMode.clamp),
        ),

        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,

        child: Center(
            child: Text(
          "TODO",
          style: TextStyle(
              fontSize: 72, fontWeight: FontWeight.bold, color: Colors.white),
        )),
      ),
    );
  }
}
*/
