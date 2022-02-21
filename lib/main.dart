import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:noteapp/screen/notes_list.dart';
import 'package:provider/provider.dart';

import 'notifier/notes_notifier.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((value) => runApp(NotesApp()));
}

class NotesApp extends StatelessWidget {
  const NotesApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => NotesNotifier())],
      child: MaterialApp(
        title: "TODO",
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.orange),
        home: NotesList(),
      ),
    );
  }
}
