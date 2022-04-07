import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:noteapp/model/notes_model.dart';

Widget noteWidget(
    {required BuildContext context,
    required NotesModel note,
    required Color color}) {
  return GestureDetector(
    child: Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: color, width: 2)),
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
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Align(
              alignment: Alignment.bottomRight,
              child: Text(
                DateFormat("dd-MM-yyyy hh:mm").format(note.createdon!),
                style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 10,
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
