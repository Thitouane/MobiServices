import 'package:flutter/material.dart';
import 'package:mobideliv/core/styles/colors.dart';

Future showPopup(
    BuildContext context, {
      Widget? contentWidget,
      String confirmText = "Confirmer",
      void Function()? onConfirm,
      String cancelText = "Annuler",
      void Function()? onCancel,
    }) {
  return showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        contentPadding:
        const EdgeInsets.symmetric(vertical: 30, horizontal: 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        actionsAlignment: MainAxisAlignment.center,
        actionsPadding:
        const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        backgroundColor: Palette.backgroundGrey,
        content: contentWidget,
        actions: [
          _actionButton(context,
              text: confirmText,
              buttonBackgroundColor: Palette.orangePrimary,
              textColor: Colors.white,
              onPressed: onConfirm),
          const SizedBox(width: 20),
          _actionButton(context,
              text: cancelText,
              buttonBackgroundColor: Colors.black,
              textColor: Colors.white,
              onPressed: onCancel),
        ],
      ));
}

TextButton _actionButton(BuildContext context,
    {required String text,
      Color? buttonBackgroundColor,
      Color textColor = Colors.white,
      void Function()? onPressed}) {
  return TextButton(
    onPressed: onPressed, // TODO Add parameter for navigation message
    style: TextButton.styleFrom(
        backgroundColor: buttonBackgroundColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15)),
    child: Text(
      text,
      style: TextStyle(
        color: textColor,
        fontWeight: FontWeight.w400,
        fontSize: 15,
      ),
    ),
  );
}


// const Text(
//                 'Voulez-vous retirer \n Coiff\'Helle de vos favoris?',
//                 style: TextStyle(
//                     color: Palette.darkGrey,
//                     fontWeight: FontWeight.w800,
//                     fontSize: 20),
//                 textAlign: TextAlign.center)
