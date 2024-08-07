import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:note/constants/strings.dart';
import 'package:note/model/note_model.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

import 'note_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Directory dir = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(dir.path);
  Hive.registerAdapter(NoteModelAdapter());
  await Hive.openBox<NoteModel>(Strings.databaseName);
  await Hive.openBox<String>(Strings.titleDatabaseName);
  runApp(const NoteApp());
}
