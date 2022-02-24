import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:noteapp/constant/strings.dart';
import 'package:noteapp/model/notes_model.dart';
import 'notes_add.dart';

class NotesList extends StatelessWidget {
  const NotesList({Key? key}) : super(key: key);
  Widget cw(BuildContext context, NotesModel note) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => NotesAdd(isUpdate: true, note: note),
          ),
        );
      },
      onLongPress: () {
        Box<NotesModel> box = Hive.box<NotesModel>(Strings.dbName);
        box.delete(int.parse((int.parse(note.id!)).toString()));
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.black, width: 1)),
        margin: const EdgeInsets.all(5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              note.title!,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 22,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Text(
              note.content!,
              style: TextStyle(
                color: Colors.grey[700],
                fontSize: 18,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Align(
                alignment: Alignment.bottomRight,
                child: Text(
                  DateFormat("dd-MM-yyyy hh:mm").format(note.createdon!),
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 10,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  ? StaggeredGrid.count(
                      crossAxisCount: 2,
                      children: map.values
                          .toList()
                          .map((e) => cw(context, e))
                          .toList())
                  : const Center(
                      child: Text(
                        "click on ' + ' to add new note",
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
