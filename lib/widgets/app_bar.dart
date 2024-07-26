import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:note/constants/strings.dart';
import 'package:note/widgets/widget.dart';

AppBar buildAppBar(
    {required BuildContext context,
    String? title,
    bool isHome = false,
    bool night = false,
    Function()? homeCallBack}) {
  return AppBar(
    // leading: isHome
    //     ? GestureDetector(
    //         onTap: homeCallBack,
    //         child: ShaderMask(
    //           shaderCallback: (Rect bounds) {
    //             return LinearGradient(
    //               colors: [Colors.red, Colors.yellow],
    //               tileMode: TileMode.mirror,
    //             ).createShader(bounds);
    //           },
    //           child: Icon(
    //             Ionicons.sparkles,
    //             color:
    //                 Colors.white, // This color will be replaced by the gradient
    //           ),
    //         ),
    //       )
    //     : null,
    elevation: 0,
    backgroundColor: night ? Colors.black54 : Colors.white,
    automaticallyImplyLeading: false,
    title: Hero(
      tag: Strings.titleHero,
      child: GestureDetector(
        onTap: () {
          if (isHome) if (context.mounted) saveTitle(context, title);
        },
        child: isHome
            ? ValueListenableBuilder(
                valueListenable:
                    Hive.box<String>(Strings.titleDatabaseName).listenable(),
                builder: (context, Box<String> box, widget) {
                  if (box.values.isNotEmpty) {
                    return Text(
                      "${box.values.first.toString()}'s notes",
                      style: Theme.of(context).textTheme.titleLarge,
                    );
                  } else {
                    return Text(
                      Strings.noteList,
                      style: Theme.of(context).textTheme.titleLarge,
                    );
                  }
                })
            : Text(
                title!,
                style: Theme.of(context).textTheme.titleLarge,
              ),
      ),
    ),
    centerTitle: true,
    actions: [
      isHome && (context.mounted)
          ? buildDeleteAll(context: context)
          : const SizedBox(),
    ],
  );
}
