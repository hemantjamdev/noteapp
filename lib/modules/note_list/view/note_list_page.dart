import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:note/modules/note_edit/note_edit.dart';
import 'package:note/modules/note_list/note_list.dart';
import 'package:note/utils/navigation.dart';
import 'package:note/widgets/widget.dart';

extension on BuildContext {
  NoteListCubit get cubit => read();
}

class NoteListPage extends StatefulWidget {
  const NoteListPage._({Key? key}) : super(key: key);

  static Widget instance() {
    return BlocProvider(
      create: (context) =>
          NoteListCubit(noteRepository: context.read())..getAllNotes(),
      child: NoteListPage._(),
    );
  }

  @override
  State<NoteListPage> createState() => NoteListPageState();
}

class NoteListPageState extends State<NoteListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _NoteListView(),
    );
  }
}

class _NoteListView extends StatelessWidget {
  _NoteListView();

  final FocusNode focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NoteListCubit, NoteListState>(
      buildWhen: (current, previous) => current.notes != previous.notes,
      builder: (context, state) {
        return SafeArea(
          child: RefreshIndicator(
            onRefresh: () async {
              context.cubit.getAllNotes();
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                TextField(
                  focusNode: focusNode,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    hintText: "Search",
                    prefixIcon: Icon(Icons.search),
                    contentPadding: EdgeInsets.zero,
                  ),
                  onChanged: (String value) {
                    context.cubit.search(value);
                    if (value.isEmpty) {
                      focusNode.unfocus();
                    }
                  },
                ),
                SizedBox(height: 20),
                Expanded(
                  child: state.notes.isEmpty
                      ? Center(child: Text("Your notes will be here"))
                      : SingleChildScrollView(
                          physics: ScrollPhysics(),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Reminders",
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  CircleAvatar(
                                    child: Icon(Icons.person),
                                  )
                                ],
                              ),
                              SizedBox(height: 20),
                              if (state.pinned)
                                Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("Pinned"),
                                      SizedBox(height: 10),
                                      StaggeredGrid.count(
                                        crossAxisCount: 2,
                                        children: state.notes
                                            .where(
                                                (element) => element.isPinned)
                                            .map(
                                              (e) => NoteCard(
                                                note: e,
                                                onTap: () {
                                                  context.navigateTo(
                                                      NoteEditPage.route(
                                                          noteModel: e));
                                                },
                                              ),
                                            )
                                            .toList(),
                                        crossAxisSpacing: 10,
                                        mainAxisSpacing: 10,
                                      ),
                                      SizedBox(height: 20),
                                    ]),
                              if (state.pinned) Text("Other"),
                              SizedBox(height: 10),
                              StaggeredGrid.count(
                                crossAxisCount: 2,
                                children: state.notes
                                    .where((element) => !element.isPinned)
                                    .map((e) => NoteCard(
                                          note: e,
                                          onTap: () async {
                                            await context.navigateTo(
                                              NoteEditPage.route(noteModel: e),
                                            );
                                            context.cubit.getAllNotes();
                                          },
                                        ))
                                    .toList(),
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10,
                              ),
                            ],
                          ),
                        ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
