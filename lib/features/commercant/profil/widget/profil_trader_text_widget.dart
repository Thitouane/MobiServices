import 'package:flutter/widgets.dart';
import 'package:mobideliv/features/commercant/profil/widget/trader_text_widget.dart';

class ProfilTraderTextWidget extends StatefulWidget {
  final String label;
  late String text;
  final ValueChanged<String> content;
  bool editable = false;
  int lines=1;

  ProfilTraderTextWidget({
    Key? key, required this.label, required this.text, required this.content, required this.editable,required this.lines,
  }) : super(key: key);

  @override
  ProfilTraderTextState createState() => ProfilTraderTextState(this.editable,this.text,this.lines);

}