import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:noteapp/constant/strings.dart';
import 'package:noteapp/model/notes_model.dart';
import 'package:noteapp/widgets/drawer.dart';
import 'package:noteapp/widgets/note.dart';
import 'notes_add.dart';

class NotesList extends StatelessWidget {
  const NotesList({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: customDrawer(context),
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          Strings.title,
          style: TextStyle(fontWeight: FontWeight.w400),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: ValueListenableBuilder(
            valueListenable: Hive.box<NotesModel>(Strings.dbName).listenable(),
            builder: (context, Box<NotesModel> box, widget) {
              Map<dynamic, NotesModel> map = box.toMap();
              return box.values.isNotEmpty
                  ? SingleChildScrollView(
                      child: StaggeredGrid.count(
                          crossAxisCount: 2,
                          children: map.values
                              .toList()
                              .map((note) => noteWidget(context, note, false))
                              .toList()),
                    )
                  : const Center(
                      child: Text(
                        Strings.noNotesInList,
                        style: TextStyle(fontSize: 22),
                      ),
                    );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const NotesAdd(isUpdate: false),
            ),
          );
        },
      ),
    );
  }
}
