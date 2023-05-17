import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:mobideliv/core/styles/colors.dart';

Future showMessageDialog(
  BuildContext context, {
  required String text,
  Color backgroundColor = Palette.orangePrimary,
  Color textColor = Colors.white,
}) {
  // TODO dissapear after certain duration
  return showDialog(
    context: context,
    barrierColor: Colors.transparent,
    builder: (BuildContext context) => Dialog(
      backgroundColor: backgroundColor,
      insetPadding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
      alignment: Alignment.bottomCenter,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: GestureDetector(
        onTap: () {
          AutoRouter.of(context).pop();
        },
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          child: Text(
            text,
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.w400,
              fontSize: 21,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    ),
  );
}
