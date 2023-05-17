import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:mobideliv/core/router/router.gr.dart';
import 'package:mobideliv/features/commercant/profil/profil_trader_page.dart';

import '../../../../core/styles/colors.dart';


class ProfilTraderBar extends StatefulWidget implements PreferredSizeWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  const ProfilTraderBar({super.key, required this.scaffoldKey});

  @override
  State<ProfilTraderBar> createState() => ProfilTraderBarState();

  @override
  final Size preferredSize = const Size.fromHeight(56.0);
}

class ProfilTraderBarState extends State<ProfilTraderBar> {
  @override
  Size get preferredSize => const Size.fromHeight(50);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Palette.orangeTheme,
      actions: [
        IconButton(
          onPressed: () =>
          AutoRouter.of(context).push(ProfilTraderRoute(edit: true, choice: "trader")
          ), icon: const Icon(
            Icons.mode_edit,
            color: Palette.darkGrey,
          ),
        ),
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
