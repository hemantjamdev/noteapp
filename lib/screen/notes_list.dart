import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:noteapp/notifier/notes_notifier.dart';
import 'package:provider/provider.dart';

import 'notes_add.dart';

class NotesList extends StatelessWidget {
  const NotesList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(elevation: 0, title: const Text("Notes"), centerTitle: true),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Consumer<NotesNotifier>(
            builder: (context, notifier, child) {
              return notifier.notes.isNotEmpty
                  ? StaggeredGrid.count(
                      crossAxisCount: 2,
                      children: notifier.notes
                          .map(
                            (note) => GestureDetector(
                              onDoubleTap: () {
                                notifier.addNote(note);
                              },
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => NotesAdd(
                                      isUpdate: true,
                                      note: note,
                                    ),
                                  ),
                                );
                              },
                              onLongPress: () {
                                if (notifier.notes.isNotEmpty) {
                                  notifier.deleteNote(note);
                                }
                              },
                              child: Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                        color: Colors.black, width: 2)),
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
                                  ],
                                ),
                              ),
                            ),
                          )
                          .toList())
                  : const Center(child: Text("no notes found"));
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
                  builder: (context) => const NotesAdd(isUpdate: false)));
        },
      ),
    );
  }
}

/// children:notifier.notes.map((e) => Container(child:Text(e.title.toString()))).toList(),
