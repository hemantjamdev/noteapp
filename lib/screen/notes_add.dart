import 'package:flutter/material.dart';
import 'package:noteapp/model/notes_model.dart';
import 'package:noteapp/notifier/notes_notifier.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class NotesAdd extends StatefulWidget {
  final NotesModel? note;
  final bool isUpdate;

  const NotesAdd({Key? key, this.note, required this.isUpdate})
      : super(key: key);

  @override
  State<NotesAdd> createState() => _NotesAddState();
}

class _NotesAddState extends State<NotesAdd> {
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();
  NotesNotifier notesNotifier = NotesNotifier();
  FocusNode contentFocusNode = FocusNode();

  addNewNote() {
    Uuid uuid = const Uuid();
    NotesModel note = NotesModel(
        id: uuid.v1(),
        // userid: uuid.v1(),
        title: titleController.text,
        content: contentController.text,
        createdon: DateTime.now());
   // Provider.of<NotesNotifier>(context, listen: false).addNote(note);
    Provider.of<NotesNotifier>(context, listen: false).addItem(note);


    //Navigator.pop(context);
  }

  noteUpdate() {
    //  Uuid uuid = const Uuid();
    NotesModel note = NotesModel(
        id: widget.note!.id,
        // userid: uuid.v1(),
        title: titleController.text,
        content: contentController.text,
        createdon: DateTime.now());
    Provider.of<NotesNotifier>(context, listen: false).addNote(note);
    Navigator.pop(context);
  }

  deleteNote() {
    Provider.of<NotesNotifier>(context, listen: false).deleteNote(widget.note!);
    Navigator.pop(context);
  }

  @override
  void initState() {
    super.initState();
    if (widget.isUpdate) {
      titleController.text = widget.note!.title!;
      contentController.text = widget.note!.content!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          widget.isUpdate
              ? IconButton(
                  onPressed: () {
                    deleteNote();
                  },
                  icon: const Icon(Icons.delete),
                )
              : const SizedBox(),
          IconButton(
            onPressed: () {
              titleController.text.isNotEmpty ? addNewNote() : noteUpdate();
            },
            icon: const Icon(Icons.done),
          )
        ],
      ),
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.all(18),
          child: Column(
            children: [
              TextField(
                autofocus: widget.isUpdate ? false : true,
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
