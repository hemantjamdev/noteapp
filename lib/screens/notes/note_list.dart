import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:note/constants/colors.dart';
import 'package:note/constants/routes_name.dart';
import 'package:note/constants/strings.dart';
import 'package:note/local_storage/local_storage.dart';
import 'package:note/model/note_model.dart';
import 'package:note/widgets/widget.dart';
import 'package:sizer/sizer.dart';

class NoteList extends StatefulWidget {
  const NoteList({Key? key}) : super(key: key);

  @override
  State<NoteList> createState() => NoteListState();
}

class NoteListState extends State<NoteList>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;

  final dbHelper = DBHelper();

  void handleDelete(String key) {
    dbHelper.delete(key: key);
  }

  @override
  void initState() {
    animationController = AnimationController(vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
          heroTag: Strings.fabHero,
          onPressed: () {
            Navigator.pushNamed(context, RoutesName.noteAddRoute);
          },
          label: const Text(Strings.add)),
      appBar: buildAppBar(
          context: context,
          title: Strings.noteList,
          isHome: true,
          night: false,
          homeCallBack: () {
            Navigator.pushNamed(context, RoutesName.geminiChatPage);
          }),
      body: Stack(
        children: [
          Container(
            alignment: Alignment.bottomCenter,
            height: 32.h,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //Lottie.asset(Strings.moon, height: 12.h),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //  Lottie.asset(Strings.chicken, height: 15.h),
                    // Lottie.asset(Strings.cow, height: 12.h)
                  ],
                ),
              ],
            ),
          ),
          DraggableScrollableSheet(
            initialChildSize: 0.67,
            minChildSize: 0.67,
            builder: (BuildContext context, ScrollController scrollController) {
              return Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25)),
                  color: AppColors.black54,
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    Container(
                      height: 5,
                      width: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColors.black,
                      ),
                    ),
                    const SizedBox(height: 10),
                    ValueListenableBuilder(
                      valueListenable: Hive.box<NoteModel>(Strings.databaseName)
                          .listenable(),
                      builder: (context, Box<NoteModel> box, widget) {
                        List<NoteModel> noteList = box.values.toList();
                        return noteList.isNotEmpty
                            ? Expanded(
                                child: ListView.builder(
                                  controller: scrollController,
                                  itemCount: noteList.length,
                                  itemBuilder: (context, int index) {
                                    return noteWidget(
                                      note: noteList[index],
                                      context: context,
                                      handleDelete: handleDelete,
                                      handleShare: (value) {},
                                    );
                                  },
                                ),
                              )
                            : const Expanded(
                                child: Center(
                                  child: Text(
                                    Strings.emptyData,
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: AppColors.white,
                                    ),
                                  ),
                                ),
                              );
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
