import 'package:flutter/material.dart';
import 'package:noteapp/constant/strings.dart';
import 'package:noteapp/local_storage/bin_database_helper.dart';
import 'package:noteapp/model/notes_model.dart';
import 'package:noteapp/widgets/confirmation_dialog.dart';

class FinalDelete extends StatefulWidget {
  final NotesModel note;
  static const String routeName='finalDelete';

  const FinalDelete({Key? key, required this.note}) : super(key: key);

  @override
  State<FinalDelete> createState() => _FinalDeleteState();
}

class _FinalDeleteState extends State<FinalDelete> {
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();
  FocusNode contentFocusNode = FocusNode();

  void deleteSingleNote({required NotesModel note}) {
    confirmationDialog(context: context, message: Strings.sureToDelete)
        .then((value) {
      if (value) {
        BinHelper.deleteSelected(note);
        Navigator.pop(context);
      }
    });
  }

  void putBack() {
    confirmationDialog(context: context, message: Strings.sureToRestore)
        .then((value) {
      if (value) {
        BinHelper.restoreSelected(widget.note);

        Navigator.pop(context);
      }
    });
  }

  @override
  void initState() {
    super.initState();

    titleController.text = widget.note.title!;
    contentController.text = widget.note.content!;
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
              onPressed: () => deleteSingleNote(note: widget.note),
              icon: const Icon(Icons.delete),
            ),
            OutlinedButton.icon(
              label: const Text(Strings.restore),
              onPressed: () => putBack(),
              icon: const Icon(Icons.refresh),
            )
          ],
        ),
      ),
      appBar: AppBar(
        title: Text(widget.note.title!),
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
