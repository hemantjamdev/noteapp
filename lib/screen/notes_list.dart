import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:noteapp/constant/strings.dart';
import 'package:noteapp/local_storage/note_database_helper.dart';
import 'package:noteapp/model/notes_model.dart';
import 'package:noteapp/widgets/drawer.dart';
import 'package:noteapp/widgets/note.dart';

class NotesList extends StatefulWidget {
  const NotesList({Key? key}) : super(key: key);
static const String routeName='noteList';
  @override
  State<NotesList> createState() => _NotesListState();
}

class _NotesListState extends State<NotesList> {
  List<NotesModel> deleteList = [];
  List<NotesModel> undoList = [];

  void addToDeleteList(NotesModel note) {
    setState(() {});
    deleteList.add(note);
  }

  void deleteSelected() {
    for (var element in deleteList) {

      undoList.add(element);
      Helper.multipleSelectedDelete(element);
    }


    showSnackBar();
    deleteList.clear();
    setState(() {});
  }

  putBack() {

    for (var element in undoList) {
      Helper.addNewNote(title: element.title!, content: element.content!);

    }

    undoList.clear();
  }

  showSnackBar() {
    SnackBar snackBar = SnackBar(
      content: const Text('note modev to recycle bin'),
      action: SnackBarAction(
        label: 'undo',
        onPressed: () {
          putBack();
        },
      ),
    );

    ScaffoldMessenger.of(context)
        .showSnackBar(snackBar)
        .closed
        .then((value) => undoList.clear());
  }

  void handleOnTap(NotesModel note) {
    Map<String, dynamic> args = {'note': note, 'isUpdate': true};
    deleteList.isEmpty
        ? Navigator.pushNamed(context, '/add', arguments: args)
        : deleteList.contains(note)
            ? removeFromDeleteList(note)
            : addToDeleteList(note);
  }

  void removeFromDeleteList(NotesModel note) {
    setState(() {});
    deleteList.remove(note);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: customDrawer(context),
      appBar: buildAppBar(),
      body: _body(),
      floatingActionButton: buildFloatingActionButton(context),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      actions: [
        deleteList.isNotEmpty
            ? IconButton(
                onPressed: () => deleteSelected(),
                icon: const Icon(Icons.delete))
            : const SizedBox()
      ],
      elevation: 0,
      title: const Text(
        Strings.title,
        style: TextStyle(fontWeight: FontWeight.w400),
      ),
      centerTitle: true,
    );
  }

  Widget _body() {
    return SafeArea(
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
                                  handleOnTap(note);
                                },
                                onLongPress: () {
                                  addToDeleteList(note);
                                },
                                child: noteWidget(
                                  context: context,
                                  note: note,
                                  color: deleteList.contains(note)
                                      ? Colors.black
                                      : Colors.grey,
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
    );
  }

  FloatingActionButton buildFloatingActionButton(BuildContext context) {
    return FloatingActionButton(
      child: const Icon(Icons.add),
      onPressed: () {
        Map<String, dynamic> args = {'note': null, 'isUpdate': false};
        Navigator.pushNamed(context, '/add', arguments: args);
      },
    );
  }
}
