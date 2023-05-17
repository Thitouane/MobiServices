import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:mobideliv/core/router/router.gr.dart';
import 'package:mobideliv/core/styles/colors.dart';

import '../profil_page.dart';

class ProfilBar extends StatefulWidget implements PreferredSizeWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  const ProfilBar({super.key, required this.scaffoldKey});

  @override
  State<ProfilBar> createState() => ProfilBarState();

  @override
  final Size preferredSize = const Size.fromHeight(56.0);
}

class ProfilBarState extends State<ProfilBar>{
  @override
  Size get preferredSize => const Size.fromHeight(100);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Palette.orangeTheme,
      actions: [
        IconButton(
          onPressed: () {
            AutoRouter.of(context).push(
              ProfilRoute(edit: true)
            );
          },
          icon: const Icon(
            Icons.mode_edit,
            color: Palette.darkGrey,
          ),
        )
      ],
      leading: IconButton(
        icon: const Icon(Icons.menu),
        iconSize: 32,
        color: Palette.darkGrey,
        onPressed: () {
          widget.scaffoldKey.currentState?.openDrawer();
        },
      ),
      title: Text(
        'Profil',
        style: TextStyle(
          color: Colors.black,
          fontSize: 18,
        ),
      ),
      centerTitle: true,
    );

  }
}

