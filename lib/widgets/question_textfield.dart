import 'package:flutter/material.dart';
import 'package:my_journaling/util/app_colors.dart';

class QuestionTextField extends StatefulWidget {
  final TextEditingController controller;
  final String textHint;
  QuestionTextField({this.textHint, this.controller});

  @override
  _QuestionTextFieldState createState() => _QuestionTextFieldState();
}

class _QuestionTextFieldState extends State<QuestionTextField> {

  @override
  Widget build(BuildContext context) {
    return  TextField(
      controller: widget.controller,
      decoration: InputDecoration(
        hintText: widget.textHint,
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColor.ACCENTCOLOR
          ),
        ),
      ),
      cursorColor: AppColor.PRIMARYCOLOR,
    );
  }
}
