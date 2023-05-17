import 'package:flutter/material.dart';
import 'package:mobideliv/features/commercant/profil/widget/profil_trader_text_widget.dart';


class ProfilTraderTextState extends State<ProfilTraderTextWidget> {
  late final TextEditingController controller;
  bool editable = false;
  String message = '';
  int lines = 1;

  @override
  void initState(){
    super.initState();
    controller = TextEditingController(text: widget.text);
  }

  ProfilTraderTextState(this.editable,this.message,this.lines);

  @override
  void dispose(){
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) =>
      Container(
        margin: EdgeInsets.symmetric(
          vertical: 15,
          horizontal: 30,
        ),
        child:Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

          Text(
          widget.label,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 8),
          TextFormField(
            maxLines: lines,
            controller: controller,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onChanged: (String value) {
              widget.text = controller.text;
            },
            readOnly: !this.editable,
          ),
        ],
        ),
  );
}
