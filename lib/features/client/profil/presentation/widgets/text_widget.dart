import 'package:flutter/material.dart';

import '../widgets/profil_text_widget.dart';

class ProfilTextState extends State<ProfilTextWidget> {
  late final TextEditingController controller;
  bool editable = false;
  String message = '';

  @override
  void initState(){
    super.initState();
    controller = TextEditingController(text: widget.text);
  }

  ProfilTextState(this.editable);

  @override
  void dispose(){
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Container(
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
          maxLines: 1,
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
