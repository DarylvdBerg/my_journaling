import 'package:flutter/material.dart';
import 'package:my_journaling/util/app_colors.dart';

class JournalContent extends StatefulWidget {
  final TextEditingController content = TextEditingController();
  final Function saveJournal;

  JournalContent({this.saveJournal});

  @override
  _JournalContentState createState() => _JournalContentState();
}

class _JournalContentState extends State<JournalContent> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      padding: EdgeInsets.only(left: 10, right: 10),
      height: MediaQuery.of(context).size.height,
      child: Column(
        children: <Widget>[
          TextField(
            controller: widget.content,
            keyboardType: TextInputType.multiline,
            maxLines: 20,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: AppColor.ACCENTCOLOR,
                ),
              ),
            ),
            cursorColor: AppColor.PRIMARYCOLOR,
          ),
          SizedBox(
            height: 30,
          ),
          RaisedButton(
            onPressed: () => widget.saveJournal(widget.content.text),
            color: Colors.white,
            child: Text(
              "Save Journal",
              style: TextStyle(
                color: AppColor.ACCENTCOLOR,
              ),
            ),
          )
        ],
      ),
    );
  }
}
