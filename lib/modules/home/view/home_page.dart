import 'dart:developer';

import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note/modules/gemini_chat/view/gemini_chat_page.dart';
import 'package:note/modules/home/cubit/home_cubit.dart';
import 'package:note/modules/note_add/view/note_add_page.dart';
import 'package:note/modules/note_list/note_list.dart';
import 'package:note/utils/navigation.dart';

extension on BuildContext {
  HomeCubit get cubit => read();
}

class HomePage extends StatelessWidget {
  HomePage._();

  static Route route() {
    return MaterialPageRoute(builder: (context) {
      return BlocProvider(
        create: (context) => HomeCubit(noteRepository: context.read()),
        child: HomePage._(),
      );
    });
  }

  final iconList = <IconData>[Icons.delete, Icons.chat];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      buildWhen: (current, previous) =>
          current.currentIndex != previous.currentIndex,
      builder: (context, state) {
        return Scaffold(
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: AnimatedBottomNavigationBar(
            icons: iconList,
            activeIndex: state.currentIndex,
            gapLocation: GapLocation.center,
            notchSmoothness: NotchSmoothness.verySmoothEdge,
            leftCornerRadius: 10,
            rightCornerRadius: 10,
            onTap: (int index) async {
              if (index == 0) {
                final bool? value = await showDialog(
                  useSafeArea: true,
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text(
                        "Sure you want to delete all notes ?",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context, true);
                          },
                          child: Text("Delete"),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context, false);
                          },
                          child: Text("Cancel"),
                        ),
                      ],
                    );
                  },
                );
                if (value != null && value) {
                  log("note deleted");
                }
              } else if (index == 1) {
                String data = await context.cubit.getAllData();
                context.navigateTo(GeminiChatPage.route(data: data));
              }
            },
          ),
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            heroTag: "fabhero",
            onPressed: () async {
              await context.navigateTo(NoteAddPage.route());
            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              child: NoteListPage.instance(),
            ),
          ),
        );
      },
    );
  }
}
