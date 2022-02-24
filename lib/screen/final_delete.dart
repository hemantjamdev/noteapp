import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:noteapp/constant/strings.dart';
import 'package:noteapp/model/notes_model.dart';
import 'package:noteapp/widgets/confirmation_dialog.dart';

class FinalDelete extends StatefulWidget {
  final NotesModel? note;

  const FinalDelete({Key? key, this.note}) : super(key: key);

  @override
  State<FinalDelete> createState() => _FinalDeleteState();
}

class _FinalDeleteState extends State<FinalDelete> {
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();
  FocusNode contentFocusNode = FocusNode();

  ///hive delete
  deleteNote() async {
    var box = await Hive.openBox<NotesModel>(Strings.binDbName);
    confirmationDialog(context: context, message: Strings.sureToDelete)
        .then((value) {
      if (value) {
        box.delete(int.parse(widget.note!.id!));
        Navigator.pop(context);
      }
    });
  }

  ///restore
  restore() {
    confirmationDialog(context: context, message: Strings.sureToRestore)
        .then((value) async {
      if (value) {
        // add note in actual database
        var binBox = await Hive.openBox<NotesModel>(Strings.dbName);
        binBox.put(int.parse(widget.note!.id!), widget.note!);

        // delete from bin database
        var box = await Hive.openBox<NotesModel>(Strings.binDbName);
        box.delete(int.parse(widget.note!.id!));

        Navigator.pop(context);
      }
    });
  }

  @override
  void initState() {
    super.initState();

    titleController.text = widget.note!.title!;
    contentController.text = widget.note!.content!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            OutlinedButton.icon(
              label: const Text(Strings.delete),
              onPressed: () {
                deleteNote();
              },
              icon: const Icon(Icons.delete),
            ),
            OutlinedButton.icon(
              label: const Text(Strings.restore),
              onPressed: () {
                restore();
              },
              icon: const Icon(Icons.refresh),
            )
          ],
        ),
      ),
      appBar: AppBar(
        title: Text(widget.note!.title!),
      ),
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.all(18),
          child: Column(
            children: [
              TextField(
                enabled: false,
                autofocus: false,
                onSubmitted: (val) {
                  contentFocusNode.requestFocus();
                },
                controller: titleController,
                decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: "Title",
                    hintStyle: TextStyle(fontSize: 26)),
              ),
              Expanded(
                child: TextField(
                  enabled: false,
                  focusNode: contentFocusNode,
                  controller: contentController,
                  maxLines: null,
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: "Notes",
                      hintStyle: TextStyle(fontSize: 24)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
