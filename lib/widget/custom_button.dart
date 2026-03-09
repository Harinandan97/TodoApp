import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {

  final String txt;
  final Color? clr;
  final void Function()? OnPressed;

  const CustomButton({required this.txt,this.clr,this.OnPressed});

  @override
  Widget build(BuildContext context) {
    return
      ElevatedButton(onPressed: OnPressed,
          style:ElevatedButton.styleFrom(
              backgroundColor:clr?? const Color(0xFF758F8E), // grey-green shade,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50)),maximumSize:const Size(double.infinity, 55),elevation: 2 )
          , child:
          Text(txt!,style: TextStyle(  color: Colors.black, // text color
            fontSize: 16,
            fontWeight: FontWeight.w500,),)
      )
    ;
  }
}
