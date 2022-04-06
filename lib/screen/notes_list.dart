
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:noteapp/constant/strings.dart';
import 'package:noteapp/model/notes_model.dart';
import 'package:noteapp/widgets/drawer.dart';
import 'package:noteapp/widgets/note.dart';
import 'package:noteapp/widgets/toast.dart';
import 'notes_add.dart';

class NotesList extends StatefulWidget {
  const NotesList({Key? key}) : super(key: key);

  @override
  State<NotesList> createState() => _NotesListState();
}

class _NotesListState extends State<NotesList> {
  List<NotesModel> deleteList = [];

  ///hive delete
  deleteNote(NotesModel note) async {
    // add note in bin database
    var binBox = await Hive.openBox<NotesModel>(Strings.binDbName);
    binBox.put(int.parse(note.id!), note);

    // delete from actual database
    var box = await Hive.openBox<NotesModel>(Strings.dbName);
    box.delete(int.parse(note.id!)).then((value) => toast(Strings.noteDeleted));
    deleteList.clear();
  }

  void addToDeleteList(NotesModel note) {
    setState(() {});
    deleteList.add(note);
  }

  delete() {
    setState(() {
      for (var element in deleteList) {
        deleteNote(element);
      }
    });
  }

  void removeFromDeleteList(NotesModel note) {
    setState(() {});
    deleteList.remove(note);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: customDrawer(context),
      appBar: AppBar(
        actions: [
          deleteList.isNotEmpty
              ? IconButton(
                  onPressed: () {
                    delete();
                  },
                  icon: const Icon(Icons.delete))
              : const SizedBox()
        ],
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
                              .map((note) => GestureDetector(
                                  onTap: () {
                                    deleteList.isEmpty
                                        ? Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => NotesAdd(
                                                  isUpdate: true, note: note),
                                            ),
                                          )
                                        : deleteList.contains(note)
                                            ? removeFromDeleteList(note)
                                            : addToDeleteList(note);
                                  },
                                  onLongPress: () {
                                    addToDeleteList(note);
                                  },
                                  child: noteWidget(
                                    context: context,
                                    note: note,
                                    width: deleteList.contains(note) ? 4 : 2,
                                  )))
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
