import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:noteapp/admob/ad_helper.dart';
import 'package:noteapp/constant/strings.dart';
import 'package:noteapp/local_storage/bin_database_helper.dart';
import 'package:noteapp/model/notes_model.dart';
import 'package:noteapp/widgets/confirmation_dialog.dart';
import 'package:noteapp/widgets/note.dart';

class Bin extends StatefulWidget {
  const Bin({Key? key}) : super(key: key);
  static const String routeName = 'bin';

  @override
  State<Bin> createState() => _BinState();
}

class _BinState extends State<Bin> {
  List<NotesModel> deleteList = [];

  void deleteSelected() {
    confirmationDialog(context: context, message: Strings.sureToDelete).then(
      (value) {
        if (value) {
          setState(
            () {
              for (var element in deleteList) {
                BinHelper.deleteSelected(element);
              }
              deleteList.clear();
            },
          );
        }
      },
    );
  }

  void putBack() {
    confirmationDialog(context: context, message: Strings.sureToRestore).then(
      (value) {
        if (value) {
          setState(
            () {
              for (var element in deleteList) {
                BinHelper.restoreSelected(element);
              }
              deleteList.clear();
            },
          );
        }
      },
    );
  }

  void addToDeleteList(NotesModel note) {
    setState(() {});
    deleteList.add(note);
  }

  void removeFromDeleteList(NotesModel note) {
    setState(() {});
    deleteList.remove(note);
  }

  void deleteAllNote(BuildContext context) async {
    confirmationDialog(context: context, message: Strings.sureToDelete).then(
      (value) {
        if (value) {
          setState(() {
            BinHelper.deleteAll();
            deleteList.clear();
          });
        }
      },
    );
  }

 /* Widget buildAdWidget() {
    return SizedBox(
      height: AdHelper.binBanner.size.height.toDouble(),
      child: AdWidget(ad: AdHelper.binBanner),
    );
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    //  bottomNavigationBar: buildAdWidget(),
      floatingActionButton: deleteAllBin(context),
      appBar: buildAppBar(),
      body: buildSafeArea(),
    );
  }

  SafeArea buildSafeArea() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: ValueListenableBuilder(
          valueListenable: Hive.box<NotesModel>(Strings.binDbName).listenable(),
          builder: (context, Box<NotesModel> box, widget) {
            Map<dynamic, NotesModel> map = box.toMap();
            return box.values.isNotEmpty
                ? SingleChildScrollView(
                    child: StaggeredGrid.count(
                      crossAxisCount: 2,
                      children: map.values
                          .toList()
                          .map(
                            (note) => GestureDetector(
                              onLongPress: () {
                                addToDeleteList(note);
                              },
                              child: noteWidget(
                                context: context,
                                note: note,
                                color: deleteList.contains(note)
                                    ? Colors.black
                                    : Colors.grey,
                              ),
                            ),
                          )
                          .toList(),
                    ),
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
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      actions: [
        deleteList.isNotEmpty
            ? IconButton(
                onPressed: () => deleteSelected(),
                icon: const Icon(Icons.delete),
              )
            : const SizedBox(),
        deleteList.isNotEmpty
            ? IconButton(
                onPressed: () => putBack(),
                icon: const Icon(Icons.drive_folder_upload),
              )
            : const SizedBox()
      ],
      elevation: 0,
      title: const Text(
        Strings.binTitle,
        style: TextStyle(fontWeight: FontWeight.w400),
      ),
      centerTitle: true,
    );
  }

  Widget deleteAllBin(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: FloatingActionButton.extended(
        label: const Text(Strings.emptyBin),
        tooltip: Strings.emptyBin,
        onPressed: () {
          deleteAllNote(context);
        },
      ),
    );
  }
}
