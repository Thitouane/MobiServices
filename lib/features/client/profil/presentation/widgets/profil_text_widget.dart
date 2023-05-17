import 'package:flutter/widgets.dart';
import 'package:mobideliv/features/client/profil/presentation/widgets/text_widget.dart';

class ProfilTextWidget extends StatefulWidget {
  final String label;
  late String text;
  final ValueChanged<String> content;
  bool editable = false;

  ProfilTextWidget({
    Key? key, required this.label, required this.text, required this.content, required this.editable
  }) : super(key: key);

  @override
  ProfilTextState createState() => ProfilTextState(this.editable);

}