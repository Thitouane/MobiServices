import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ProfilTraderAreaWidget extends StatefulWidget {
  final String label;
  late String text;
  final ValueChanged<String> content;
  bool editable = false;

  ProfilTraderAreaWidget({
    Key? key, required this.label, required this.text, required this.content, required this.editable
  }) : super(key: key);

  @override
  ProfilTraderAreaState createState() => ProfilTraderAreaState(this.editable);

}


class ProfilTraderAreaState extends State<ProfilTraderAreaWidget> {
  late final TextEditingController controller;
  bool editable = false;
  String message = '';

  @override
  void initState(){
    super.initState();
    controller = TextEditingController(text: widget.text);
  }

  ProfilTraderAreaState(this.editable);

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
              maxLines: 4,
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
