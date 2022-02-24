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
