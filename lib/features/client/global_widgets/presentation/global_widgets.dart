import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:mobideliv/core/presentation/client/app_bar.dart';
import 'package:mobideliv/core/presentation/client/navbar.dart';
import 'package:mobideliv/core/presentation/popup_prompt.dart';
import 'package:mobideliv/core/presentation/popup_message.dart';
import 'package:mobideliv/core/styles/colors.dart';

class GlobalWidgets extends StatelessWidget {
  GlobalWidgets({super.key});
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: NavBar(),
      appBar: CustomAppBar(scaffoldKey: _scaffoldKey),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
          TextButton(
            onPressed: () => showPopup(
              context,
              confirmText: "Confirmer",
              onConfirm: () => AutoRouter.of(context).pop(),
              cancelText: "Annuler",
              onCancel: () => AutoRouter.of(context).pop(),
              contentWidget: const Text(
                  'Voulez-vous bien faire ce que voulez faire ?',
                  style: TextStyle(
                      color: Palette.darkGrey,
                      fontWeight: FontWeight.w500,
                      fontSize: 20),
                  textAlign: TextAlign.center),
            ),
            style: TextButton.styleFrom(
              backgroundColor: Colors.blue,
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            child: const Text(
              "Click Popup Prompt",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 21,
                  fontWeight: FontWeight.w500),
            ),
          ),
          const SizedBox(height: 40),
          TextButton(
            onPressed: () => showMessageDialog(
              context,
              text: "This is a test",
              backgroundColor: Palette.orangePrimary,
            ),
            style: TextButton.styleFrom(
              backgroundColor: Colors.teal,
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            child: const Text(
              "Click Popup Message",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 21),
            ),
          ),
          const SizedBox(height: 40),
        ]),
      ),
    );
  }
}
