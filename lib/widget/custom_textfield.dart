import 'dart:ui';

import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String? Label;
  final String? Hint;
  final bool? filled;
  final Color? Colorz;
  final InputBorder? border;
  final InputBorder? second;
  final TextEditingController? controller;
  final Color? clr;
  final Color? fclr;

  const CustomTextField({
    this.Label,
    this.Hint,
    this.filled,
    this.Colorz,
    this.border,
    this.second,
    this.controller,
    this.clr,
    this.fclr,

  });

  @override
  Widget build(BuildContext context) {
    return
      TextFormField(

        controller:controller ,
        decoration: InputDecoration(
            filled:filled ?? true,
            fillColor:Colorz ?? Color(0xFFF3F3F3) ,
            labelText: Label,labelStyle: TextStyle(color: Colors.black,fontSize: 18),
            hintText: Hint,hintStyle: TextStyle(color: Colors.grey[19]),

            floatingLabelBehavior: FloatingLabelBehavior.always,//label always on the top
            enabledBorder:border?? OutlineInputBorder(borderRadius: BorderRadius.circular(20),borderSide: BorderSide(
                color:clr ?? Color(0xFFF3F3F3)
            )),
            focusedBorder:second?? OutlineInputBorder(borderRadius: BorderRadius.circular(20),borderSide: BorderSide(color:fclr?? Color(0xFFF3F3F3)))

        ),
      );
  }
}
