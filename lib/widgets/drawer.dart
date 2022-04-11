import 'package:flutter/material.dart';
import 'package:noteapp/constant/strings.dart';

Widget customDrawer(BuildContext context) {
  return Drawer(
    backgroundColor: Colors.orangeAccent[100],
    child: ListView(
      children: <Widget>[
        const DrawerHeader(
          child: Text(Strings.title),
        ),
        ListTile(
          onTap: () {
            Navigator.pop(context);
            Navigator.pushNamed(context, '/bin');
          },
          leading: const Icon(Icons.delete),
          title: const Text(Strings.recycleBin),
        ),
        ListTile(
          onTap: () {
            Navigator.pop(context);
           // Navigator.pushNamed(context, '/bin');
          },
          leading: const Icon(Icons.logout),
          title: const Text(Strings.logout),
        ),
      ],
    ),
  );
}
