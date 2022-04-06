import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:noteapp/constant/strings.dart';
import 'package:noteapp/model/notes_model.dart';
import 'package:noteapp/widgets/confirmation_dialog.dart';
import 'package:noteapp/widgets/note.dart';
import 'package:noteapp/widgets/toast.dart';

import 'final_delete.dart';

class Bin extends StatefulWidget {
  const Bin({Key? key}) : super(key: key);

  @override
  State<Bin> createState() => _BinState();
}

class _BinState extends State<Bin> {
  List<NotesModel> deleteList = [];

  ///hive delete
  deleteNote(NotesModel note) async {
    var box = await Hive.openBox<NotesModel>(Strings.binDbName);
    box.delete(int.parse(note.id!));
    deleteList.clear();
  }

  void addToDeleteList(NotesModel note) {
    setState(() {});
    deleteList.add(note);
  }

  delete() {
    confirmationDialog(context: context, message: Strings.sureToDelete)
        .then((value) {
      if (value) {
        setState(() {
          for (var element in deleteList) {
            deleteNote(element);
          }
        });
      }
    });
  }

  restore() {
    confirmationDialog(context: context, message: Strings.sureToDelete)
        .then((value) {
      if (value) {
        setState(() {
          for (var element in deleteList) {
            restoreSelected(element);
          }
        });
      }
    });
  }

  /// put back to main database
  void restoreSelected(NotesModel note) async {
    var binBox = await Hive.openBox<NotesModel>(Strings.dbName);
    binBox.put(int.parse(note.id!), note);

    // delete from bin database
    var box = await Hive.openBox<NotesModel>(Strings.binDbName);
    box.delete(int.parse(note.id!));
    deleteList.clear();
  }

  void removeFromDeleteList(NotesModel note) {
    setState(() {});
    deleteList.remove(note);
  }

  /// delete whole database
  deleteAllNote(BuildContext context) async {
    var box = await Hive.openBox<NotesModel>(Strings.binDbName);
    if (box.isNotEmpty) {
      confirmationDialog(context: context, message: Strings.sureToDelete)
          .then((value) {
        if (value) {
          box.deleteAll(box.keys);
        }
      });
    } else {
      toast(Strings.binIsEmpty);
    }
  }

  @override
  Widget build(BuildContext context) {
    log("build method of note list screen");
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(12.0),
        child: OutlinedButton.icon(
          label: const Text(Strings.emptyBin),
          onPressed: () {
            deleteAllNote(context);
          },
          icon: const Icon(Icons.delete),
        ),
      ),
      appBar: AppBar(
        actions: [
          deleteList.isNotEmpty
              ? IconButton(
                  onPressed: () {
                    delete();
                  },
                  icon: const Icon(Icons.delete))
              : const SizedBox(),
          deleteList.isNotEmpty
              ? IconButton(
                  onPressed: () {
                    restore();
                  },
                  icon: const Icon(Icons.drive_folder_upload))
              : const SizedBox()
        ],
        elevation: 0,
        title: const Text(
          Strings.binTitle,
          style: TextStyle(fontWeight: FontWeight.w400),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: ValueListenableBuilder(
            valueListenable:
                Hive.box<NotesModel>(Strings.binDbName).listenable(),
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
                                              builder: (context) =>
                                                  FinalDelete(note: note),
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
                        Strings.noNotesInBin,
                        style: TextStyle(fontSize: 18),
                      ),
                    );
            },
          ),
        ),
      ),
    );
  }
}
