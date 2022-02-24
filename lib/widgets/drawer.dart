import 'package:flutter/material.dart';
import 'package:noteapp/constant/strings.dart';
import 'package:noteapp/screen/recycle_bin.dart';

Widget customDrawer(BuildContext context) {
  return Drawer(
    child: ListView(
      children: <Widget>[
        const DrawerHeader(
          child: Text(Strings.title),
        ),
        ListTile(
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => const Bin()));
          },
          leading: const Icon(Icons.delete),
          title: const Text(Strings.recycleBin),
        ),
      ],
    ),
  );
}
