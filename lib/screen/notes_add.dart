import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:noteapp/constant/strings.dart';
import 'package:noteapp/model/notes_model.dart';

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
  FocusNode contentFocusNode = FocusNode();

  ///hive method
  addNewNote() async {
    String _id = (DateTime.now().year.toString() +
            DateTime.now().hour.toString() +
            DateTime.now().minute.toString() +
            DateTime.now().second.toString())
        .toString();

    NotesModel item = NotesModel(
        id: _id,
        // userid: uuid.v1(),
        title: titleController.text,
        content: contentController.text,
        createdon: DateTime.now());
    var box = await Hive.openBox<NotesModel>(Strings.dbName);

    box.put(int.parse(_id), item);
    Navigator.pop(context);
  }

  ///hive delete
  deleteNote() async {
    var box = await Hive.openBox<NotesModel>(Strings.dbName);
    box.delete(int.parse(widget.note!.id!));
  }

  /// hive update
  noteUpdate() async {
    NotesModel item = NotesModel(
        id: widget.note!.id!,
        // userid: uuid.v1(),
        title: titleController.text,
        content: contentController.text,
        createdon: DateTime.now());
    var box = await Hive.openBox<NotesModel>(Strings.dbName);
    box.put(int.parse(widget.note!.id!), item);
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
              if (titleController.text.isNotEmpty) {
                widget.isUpdate ?  noteUpdate():addNewNote();
              }
            },
            icon: const Icon(Icons.done),
          ),
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
