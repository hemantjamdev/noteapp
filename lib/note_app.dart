import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note/modules/splash/view/splash_page.dart';
import 'package:note/repository/note_repository.dart';
import 'package:sizer/sizer.dart';

class NoteApp extends StatefulWidget {
  const NoteApp({Key? key}) : super(key: key);

  @override
  State<NoteApp> createState() => _NoteAppState();
}

class _NoteAppState extends State<NoteApp> {
  late NoteRepository _noteRepository;

  @override
  void initState() {
    _noteRepository = NoteRepository();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MultiRepositoryProvider(
          providers: [
            RepositoryProvider.value(value: _noteRepository),
          ],
          child: MaterialApp(
            themeMode: ThemeMode.system,
            title: "Note",
            theme: ThemeData(useMaterial3: true),
            debugShowCheckedModeBanner: false,
            home: SplashPage.instance(),
          ),
        );
      },
    );
  }
}
