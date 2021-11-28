// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({
    Key? key,
    this.height,
    this.logOut,
  }) : super(key: key);
  final height;
  final logOut;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            height: height(200.00),
            color: Colors.lightBlue,
            child: const Center(
              child: Icon(
                Icons.coronavirus_rounded,
                color: Colors.white,
                size: 55,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(
              Icons.logout_rounded,
              color: Colors.lightBlue,
            ),
            title: const Text(
              'Logout',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            onTap: () {
              //Drawer close
              Navigator.pop(context);
              logOut();
            },
          ),
        ],
      ),
    );
  }
}
