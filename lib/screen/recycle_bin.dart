import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:noteapp/constant/strings.dart';
import 'package:noteapp/model/notes_model.dart';
import 'package:noteapp/widgets/confirmation_dialog.dart';
import 'package:noteapp/widgets/note.dart';
import 'package:noteapp/widgets/toast.dart';

class Bin extends StatelessWidget {
  const Bin({Key? key}) : super(key: key);
  deleteNote(BuildContext context) async {
    var box = await Hive.openBox<NotesModel>(Strings.binDbName);
    if (box.isNotEmpty) {
      confirmationDialog(context: context,message: Strings.sureToDelete).then((value) {
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
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(12.0),
        child: OutlinedButton.icon(
          label: const Text(Strings.emptyBin),
          onPressed: () {
            deleteNote(context);
          },
          icon: const Icon(Icons.delete),
        ),
      ),
      appBar: AppBar(
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
                              .map((note) => noteWidget(context, note, true))
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
