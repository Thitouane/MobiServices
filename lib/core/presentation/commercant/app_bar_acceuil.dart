import 'package:flutter/material.dart';
import 'package:mobideliv/core/router/router.gr.dart';
import 'package:mobideliv/core/styles/colors.dart';
import 'package:auto_route/auto_route.dart';
class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;


  const CustomAppBar({super.key, required this.scaffoldKey});

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();

  @override
  final Size preferredSize = const Size.fromHeight(56.0);
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Palette.orangeTheme,
      title: GestureDetector(
        onTap: () {
          AutoRouter.of(context).push(HomeCommercantRoute());
        },
        child: Image.asset(
          "assets/mobideliv.png",
          width: 50,
          height: 50,
        ),
      ),
      centerTitle: true,
      leading: IconButton(
        icon: const Icon(Icons.menu),
        iconSize: 32,
        color: Palette.darkGrey,
        onPressed: () {
          widget.scaffoldKey.currentState?.openDrawer();
        },
      ),
    );
  }
}
