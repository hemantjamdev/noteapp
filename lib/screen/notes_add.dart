import 'package:flutter/material.dart';
import 'package:noteapp/constant/strings.dart';
import 'package:noteapp/local_storage/note_database_helper.dart';
import 'package:noteapp/model/notes_model.dart';
import 'package:noteapp/widgets/toast.dart';

class NotesAdd extends StatefulWidget {
  final Map<String, dynamic> map;
  static const String routeName='noteAdd';

  const NotesAdd({Key? key, required this.map}) : super(key: key);

  @override
  State<NotesAdd> createState() => _NotesAddState();
}

class _NotesAddState extends State<NotesAdd> {
  TextEditingController titleController = TextEditingController();

  TextEditingController contentController = TextEditingController();

  FocusNode contentFocusNode = FocusNode();
  late NotesModel note;
  late bool isUpdate;

  void deleteSingleNote({required NotesModel note}) {
    Helper.deleteSingleNote(note: note);
    Navigator.pop(context);
  }

  void noteUpdate(
      {required String id, required String title, required String content}) {
    Helper.noteUpdate(id: id, title: title, content: content);
    Navigator.pop(context);
  }

  void addNewNote({required String title, required String content}) {
    Helper.addNewNote(title: title, content: content);
    Navigator.pop(context);
  }

  @override
  void initState() {
    super.initState();
    if (widget.map['note'] != null) {
      setState(() {
        note = widget.map['note'];
        isUpdate = true;
        titleController.text = note.title!;
        contentController.text = note.content!;
      });
    } else {
      setState(() {
        note = NotesModel();
        isUpdate = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: buildSafeArea(),
    );
  }

  SafeArea buildSafeArea() {
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.all(18),
        child: Column(
          children: [
            TextField(
              textInputAction: TextInputAction.next,
              autofocus: isUpdate ? false : true,
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
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      actions: [
        isUpdate
            ? IconButton(
                onPressed: () => deleteSingleNote(note: note),
                icon: const Icon(Icons.delete),
              )
            : const SizedBox(),
        IconButton(
          onPressed: () {
            if (titleController.text.isNotEmpty ||
                contentController.text.isNotEmpty) {
              isUpdate
                  ? noteUpdate(
                      id: note.id!,
                      content: contentController.text,
                      title: titleController.text)
                  : addNewNote(
                      title: titleController.text,
                      content: contentController.text);
            } else {
              Navigator.pop(context);
              toast(Strings.noteDiscarded);
            }
          },
          icon: const Icon(Icons.done),
        ),
      ],
    );
  }
}
