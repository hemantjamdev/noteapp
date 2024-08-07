import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:note/model/note_model.dart';
import 'package:note/utils/date_formate.dart';

class NoteCard extends StatelessWidget {
  const NoteCard({super.key, required this.note, required this.onTap});

  final NoteModel note;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      onLongPress: () {},
      child: IntrinsicHeight(
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
              color: Color(note.color),
              borderRadius: BorderRadius.circular(10)),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (note.isPinned)
                    Align(
                      alignment: Alignment.topRight,
                      child: Icon(Icons.push_pin, size: 18),
                    ),
                  Text(
                    note.title ?? "",
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 10),
                  Text(
                    note.description ?? "",
                    style: TextStyle(fontSize: 14),
                    maxLines: 20,
                  ),
                  SizedBox(height: 10),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                      border: Border.all(color: Colors.black),
                    ),
                    padding: EdgeInsets.all(2),
                    child: Text(
                      note.date.formattedDate(),
                      style: TextStyle(fontSize: 10),
                    ),
                  ),
                ],
              ),
              if (note.isPrivate)
                ClipRect(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(
                      sigmaX: 8.0,
                      sigmaY: 8.0,
                    ),
                    child: Align(
                      alignment: Alignment.center,
                      child: const Icon(
                        Icons.lock,
                        color: Colors.grey,
                        size: 42,
                      ),
                    ),
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}
